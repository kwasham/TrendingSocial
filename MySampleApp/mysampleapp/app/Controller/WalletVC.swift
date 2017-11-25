//
//  WalletVC.swift
//  MySampleApp
//
//  Created by Kirk Washam on 11/19/17.
//

import UIKit
import Geth

class WalletVC: UIViewController {

    @IBOutlet weak var textbox: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let datadir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        let ks = GethNewKeyStore(datadir + "/keystore", GethLightScryptN, GethLightScryptP)
        
        // Create a new account with the specified encryption passphrase.
        let newAcc = try! ks?.newAccount("Creation password")
        textbox.text = "New: " + newAcc!.getAddress().getHex() + "\n"
        
        
        // Export the newly created account with a different passphrase. The returned
        // data from this method invocation is a JSON encoded, encrypted key-file.
        let jsonKey = try! ks?.exportKey(newAcc!, passphrase: "Creation password", newPassphrase: "Export password")
        textbox.text = textbox.text + "JSON: " + (NSString(data: jsonKey!, encoding: String.Encoding.utf8.rawValue)! as String) + "\n"
        
        
        // Update the passphrase on the account created above inside the local keystore.
        try! ks?.update(newAcc, passphrase: "Creation password", newPassphrase: "Update password")
        textbox.text = textbox.text + "Accs: " + String(describing: ks!.getAccounts().size()) + "\n"
        
        
        // Delete the account updated above from the local keystore.
        try! ks?.delete(newAcc, passphrase: "Update password")
        
        
        // Import back the account we've exported (and then deleted) above with yet
        // again a fresh passphrase.
        let impAcc  = try! ks?.importKey(jsonKey, passphrase: "Export password", newPassphrase: "Import password")
        textbox.text = textbox.text + "Imp: " + impAcc!.getAddress().getHex()
        
        
        // Create a new account to sign transactions with
        var error: NSError?
        let signer = try! ks?.newAccount("Signer password")
        
        let to    = GethNewAddressFromHex("0x0000000000000000000000000000000000000000", &error)
        let tx    = GethNewTransaction(1, to, GethNewBigInt(0), GethNewBigInt(0), GethNewBigInt(0), nil) // Random empty transaction
        let chain = GethNewBigInt(1) // Chain identifier of the main net
        
        // Sign a transaction with a single authorization
        var signed = try! ks?.signTxPassphrase(signer, passphrase: "Signer password", tx: tx, chainID: chain)
        
        // Sign a transaction with multiple manually cancelled authorizations
        try! ks?.unlock(signer, passphrase: "Signer password")
        signed = try! ks?.signTx(signer, tx: tx, chainID: chain)
        try! ks?.lock(signer?.getAddress())
        
        // Sign a transaction with multiple automatically cancelled authorizations
        try! ks?.timedUnlock(signer, passphrase: "Signer password", timeout: 1000000000)
        signed = try! ks?.signTx(signer, tx: tx, chainID: chain)
    }

}
