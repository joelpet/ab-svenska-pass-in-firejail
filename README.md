# AB Svenska Pass in Firejail

This project attempts to mitigate an arbitrary code execution issue with Swedish eID [AB Svenska Pass](https://www.thalesgroup.com/en/europe/sweden/digital-identity-services-sweden/svensk-elegitimation/skatteverkets-id) by sandboxing it using [Firejail](https://firejail.wordpress.com/).

AB Svenska Pass is, at the time of writing, the only Swedish eID for private individuals that qualifies for the highest trust level, as defined by [DIGG](https://www.digg.se/digitala-tjanster/e-legitimering).
Technically, it is based on [smart card](https://en.wikipedia.org/wiki/Smart_card) technology.
Thus, it requires a smart card reader along with the necessary software to access it.
On GNU/Linux, this requirement can be satisfied by the `pcscd` package, which is free (libre) software.
Unfortunately, the AB Svenska Pass eID additionally requires nonfree (proprietary) software;
it is distributed as a web browser add-on.
Once installed, the add-on instructs the user to download a tarball and run an installation script from it.
The script sets up [native messaging](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/Native_messaging) between the add-on and some nonfree software from the tarball.
As a result, AB Svenska Pass gets [arbitrary code execution](https://en.wikipedia.org/wiki/Arbitrary_code_execution) on the local machine.

In Sweden today, all available eIDs subject the user to nonfree software.
For example, the most widely used, [(Mobilt) BankID](https://www.bankid.com/), is only available on nonfree operating systems such as Microsoft Windows, Apple macOS, Apple iOS, and Google Android.
At least, AB Svenska Pass runs on the free operating system GNU/Linux—Ubuntu is even officially supported.
With the nonfree parts sandboxed, AB Svenska Pass may be be considered the lesser of two evils where the alternative is some other eID that is not even available for any free operating system.

## Warning

From [Firejail - ArchWiki](https://wiki.archlinux.org/index.php?title=Firejail):

> Running untrusted code is never safe, sandboxing cannot change this.

## Usage

1. Visit a web site that offers signing in using AB Svenska Pass, e.g. [Skatteverket](https://www.skatteverket.se/).
2. Try to sign in with AB Svenska Pass.
3. Install the browser add-on when prompted.
4. Download the tarball (named something like sconnect-host-vX.Y.Z.W.tar.gz) when offered, but **do not execute anything from it**.
5. Instead, extract its contents into this project directory.
6. Run `make install`.

You should now be able to sign in using AB Svenska Pass.

### Requirements

- [GNU Make](https://www.gnu.org/software/make/)
- [Firejail](https://firejail.wordpress.com/)
