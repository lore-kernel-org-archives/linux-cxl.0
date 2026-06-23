Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE02A34574B
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jun 2026 04:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190460; cv=none; b=c6mkHgoJYhAarPoFtU3OSbjpM3ZHJAgCeSSVNqobMfGOfrHg+icsKdGjen9YjeZvZmq+oRTSqv7XEny+D1UcRNqArfRD0b8UiMmXjjN8sY+HcK0nb2egWR64EBVxcsTzCBcfKAjo1LBvFucCxHS9Hui8u8veP10KChyodibdecI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190460; c=relaxed/simple;
	bh=TmzJIOeajc3y6yKWWPTyzKZKE7v1CL8E2Cnh9XKPW+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ebyFZZlnG4MmC9rZMYRxohEHHjJxyUr/x/4fycWUZBSapWas5RFdTxB7CNOfDr97It2dlEqZe7eseo2SbgrEvvSe/GkqYLaAnxAurjsN3sPSS/B4LCH8KYZwFL1zwcT2CLp0FZc4AAgcb/MrP7GBQRMYtkmLfuIL6ZyvLjMzNfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kv4Fy967; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv4Fy967"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so37165835ad.2
        for <linux-cxl@vger.kernel.org>; Mon, 22 Jun 2026 21:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190458; x=1782795258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CW+buzTui5B/9lOmARdKDKitwynKTxiqgJLpijr22es=;
        b=kv4Fy967j4Ec+NtxNMIRzYvsEUo4fxitbEa3EtzWYozYePj5WpwHDEPFSPrdLXDqRB
         EJg/8oN8epHlkBj3jjqONOpPreKsE38Vc7bIcxRRj44P79sTZtq59xVjL2+Rw2XJV7ZQ
         adfucoGuZSrML2OxM5Z5s3SUtQ3yeZMQmP6YCOqWW8yn33qWrQ18RqyCtKibXrl0Nofy
         70aJmSHrVjl+DYJ3bF8hEZUJ5NjmX4THrjfzRD7YJfU3v4/BTPtp+vjp/E6DSYtp+cE4
         T3Dbc+k61BeIpMiySZh5/IwlWsD3j/HIl3DtT964tZjfo4h1JCUZsJo2tLKQjF5H9DEm
         QOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190458; x=1782795258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW+buzTui5B/9lOmARdKDKitwynKTxiqgJLpijr22es=;
        b=dOkBSx+jRwRq3nUxyQOU6wY5t51fCXuxYdtPy4WoSVFzGMOb+Yma6x/ERBNqeG3kV4
         sU6B74RP0JoLIwdV1wV7SwlpGLYbFDST+kDxM/cV6Dn2iuHd4Apgf92JP0Cwd03YEqif
         Toc5UrgZi/Amh3L6yMWBj+vd5GDjgrdxTo1J21354BwPKbQcJIOAFQQ0Vllo/OOqOZQt
         YiQPcHE4lgwDpQehmwe7vRfAN8L4EBs4Y88Zs9gb5bMBlGuDU3XR4cWG3HGexdkuCgGz
         7/iuJNJCe8bCsBZYQ1YWPyXPKRMFFBPt76GyRx9nEJD0u0OM8xy+2RDD3HarUSU7Bq0B
         ISUQ==
X-Forwarded-Encrypted: i=1; AHgh+RrvtgC46Z7QSuQLVST/+6afvqsZRFP/DgbDDtvaZGQwzqvzyRHlOMlA8zSY5z/A6puakhLnYfytOL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp+XLHGxcbmlg2G2bsOMipNFyukMfXuUAH3KSB5w8KJRPBZP7o
	ETCKxCzsil/UpGVrsjwnQ/sWHHV3kZzS+I/5M7ZohvZOuetOL/JfDRK2
X-Gm-Gg: AfdE7cn4h+ol63/CZUQ5n0AbmlJdX7bNaSXvmO2G804P7QLh4sLllXfCLMK2dtaK9B7
	Y1pyhORFy5VSp52xV2TImfFk+vQTyV9BZ7QcuCeedfyuOhweAa2PUKqSryn06/7a59E7yO7b40O
	4fNdiWtOBuoZLV9RLacqyLFmSWczAVmiKBvCZvtENMmnMWHXDu7cNgMDpZ22zot745I1jOWZ0oA
	GIRhWO7cjV8/bi28hkeO+XV0R6xmVEzRG9IFVJiLbKIOBwmY1wVpgmixOczQVmYEaphdl0BvGyb
	r8atMSaLMITcLDX7U0r1ehWBMAmIEfk8jTS6iO6WFtEdE9ofcAIeKXpaaDQ3sBtm6UhFGYWnbUF
	/YnqZmBkPN0oRVuZ1I5PgBADXYNX0dYcesFw8RWI79Dsd5sSpjFRvmMeSsbIU+m6r4jE+kb1js8
	XC/4Z7DN14q/B19f4aHjyhiP1QnaV2fQ==
X-Received: by 2002:a17:902:e54d:b0:2c6:b38b:e75d with SMTP id d9443c01a7336-2c7c7693e00mr15070475ad.20.1782190457940;
        Mon, 22 Jun 2026 21:54:17 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:54:17 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com
Cc: alistair23@gmail.com,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	tmgross@umich.edu,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 00/21] lib: Rust implementation of SPDM
Date: Tue, 23 Jun 2026 14:53:45 +1000
Message-ID: <20260623045406.2589547-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Security Protocols and Data Models (SPDM) [1] is used for authentication,
attestation and key exchange. SPDM is generally used over a range of
transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.

From the kernels perspective SPDM is used to authenticate and attest devices.
In this threat model a device is considered untrusted until it can be verified
by the kernel and userspace using SPDM. As such SPDM data is untrusted data
that can be mallicious.

The SPDM specification is also complex, with the 1.2.1 spec being almost 200
pages and the 1.3.0 spec being almost 250 pages long.

As such we have the kernel parsing untrusted responses from a complex
specification, which sounds like a possible exploit vector. This is the type
of place where Rust excels!

This series implements a SPDM requester in Rust.

This is based on Lukas' C implementation [2], but has been refacted during the
first few RFCs. I have included some of the relevent patchesfrom Lukas' C
SPDM implementation in this series where they are required.

This is a standalone series and doesn't depend on Lukas' implementation.

The goal of this series is to get the smallest possible SPDM implementation
upstream. That will provide building blocks for us to continue working on.

As such we don't yet provide evidence or certificates to userspace, allow
userspace to provide a nonce, support PQC or more advanced SPDM features.
This is enough to communicate with a device and return "authenticated" to
userspace.

Note that RFC v3 did provide evidence and certificates to userspace and
allowed a custom nonce. Showing that it's possible. I also have patches
that build apon [4] to do this via a TSM driver, again showing it's
possible with the current approach.
We just don't support it yet and for TSM I need [4] upstream first.

This series is different to Lukas' original approach and the approach taken
in the previous RFCs and instead adds the PCI-CMA support as a TSM driver.
This was described by Dan in [3] and [5]. The advantage here is that for PCIe
we can leverage the TSM work for a lot of the features and provide userspace
a consistient interface between PCI TSM and CMA.

This series also doesn't check the certificate chain against the kernel
keyring and will instead leave that to userspace once [4] is merged.

Other transport mode (such as ATA, SCSI, NVMe and MCTP) will
therefore need slightly different approaches, as TSM doesn't apply.
The library can support this though, it will just need some netlink
and sysfs wrappers added as applicable. This way each transport can support
SPDM in the way it sees fit.

The entire tree can be seen here:
https://github.com/alistair23/linux/tree/alistair/spdm-rust-tsm

I'm testing this by running the following

```shell
cargo run -- --qemu-server response

qemu-system-x86_64 \
  -nic none \
  -object rng-random,filename=/dev/urandom,id=rng0 \
  -device virtio-rng-pci,rng=rng0 \
  -drive file=deploy/images/qemux86-64/core-image-pcie-qemux86-64.rootfs.ext4,if=virtio,format=raw \
  -usb -device usb-tablet -usb -device usb-kbd \
  -cpu Skylake-Client \
  -machine q35,i8042=off \
  -smp 4 -m 2G \
  -drive file=blknvme,if=none,id=mynvme,format=raw \
  -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323,spdm_trans=doe \
  -snapshot \
  -serial mon:stdio -serial null -nographic \
  -kernel deploy/images/qemux86-64/bzImage \
  -append 'root=/dev/vda rw  console=ttyS0 console=ttyS1 oprofile.timer=1 tsc=reliable no_timer_check rcupdate.rcu_expedited=1 swiotlb=0 '

ls /sys/devices/pci0000:00/0000:00:03.0/
ls /sys/devices/pci0000:00/0000:00:03.0/tsm/
cat  /sys/devices/pci0000:00/0000:00:03.0/authenticated
echo tsm0 > /sys/devices/pci0000:00/0000:00:03.0/tsm/connect
cat  /sys/devices/pci0000:00/0000:00:03.0/authenticated
```

1: https://www.dmtf.org/standards/spdm
2: https://lore.kernel.org/all/cover.1719771133.git.lukas@wunner.de/
3: http://lore.kernel.org/69976d7d39c60_2f4a1009@dwillia2-mobl4.notmuch
4: https://lore.kernel.org/all/69976d7d39c60_2f4a1009@dwillia2-mobl4.notmuch/
5: https://lore.kernel.org/lkml/69e19c80b892b_fe0831000@djbw-dev.notmuch/

v2:
 - Tidy up the PCI/TSM function naming and is_pci_tsm_host()
 - A large number of changes (mostly to the Rust code) based on Sashiko reviews
     - This includes a few local runs of Sashiko
     - This has fixed a few undefined behviour bugs in the Rust code
 - Rebase on v4 of Benno's validate patches (patch 1, 2, 3)
v1:
 - Add CMA as a TSM driver
 - Initial support for SPDM 1.4
 - Cleanup a range of comments and concerns from RFC
 - Remove kernel keyring checks
RFC v3:
 - Use netlink to send information to userspace
 - Don't autogenerate Rust helpers
RFC v2:
 - Drop support for Rust and C implementations
 - Include patches from Lukas to reduce series deps
 - Large code cleanups based on more testing
 - Support for authentication

Alistair Francis (14):
  rust: add bindings for hash.h
  rust: error: impl From<FromBytesWithNulError> for Kernel Error
  lib: rspdm: Initial commit of Rust SPDM
  PCI/TSM: Rename pf0 to host
  PCI/TSM: Support connecting to PCIe CMA devices
  PCI/CMA: Add a PCI TSM CMA driver using SPDM
  lib: rspdm: Support SPDM get_version
  lib: rspdm: Support SPDM get_capabilities
  lib: rspdm: Support SPDM negotiate_algorithms
  lib: rspdm: Support SPDM get_digests
  lib: rspdm: Support SPDM get_certificate
  lib: rspdm: Support SPDM certificate validation
  rust: allow extracting the buffer from a CString
  lib: rspdm: Support SPDM challenge

Benno Lossin (3):
  rust: transmute: add `cast_slice[_mut]` functions
  rust: create basic untrusted data API
  rust: validate: add `Validate` trait

Lukas Wunner (4):
  X.509: Make certificate parser public
  X.509: Parse Subject Alternative Name in certificates
  X.509: Move certificate length retrieval into new helper
  PCI/CMA: Validate Subject Alternative Name in certificates

 MAINTAINERS                               |   13 +
 crypto/asymmetric_keys/x509_cert_parser.c |    9 +
 crypto/asymmetric_keys/x509_loader.c      |   38 +-
 crypto/asymmetric_keys/x509_parser.h      |   42 +-
 drivers/crypto/ccp/sev-dev-tio.h          |    4 +-
 drivers/crypto/ccp/sev-dev-tsm.c          |   12 +-
 drivers/pci/Kconfig                       |   14 +
 drivers/pci/Makefile                      |    5 +
 drivers/pci/cma.asn1                      |   41 +
 drivers/pci/cma.c                         |  275 +++++
 drivers/pci/doe.c                         |    3 -
 drivers/pci/tsm.c                         |   84 +-
 include/keys/asymmetric-type.h            |    2 +
 include/keys/x509-parser.h                |   57 +
 include/linux/oid_registry.h              |    3 +
 include/linux/pci-doe.h                   |    4 +
 include/linux/pci-tsm.h                   |   29 +-
 include/linux/spdm.h                      |   37 +
 lib/Kconfig                               |   14 +
 lib/Makefile                              |    2 +
 lib/rspdm/Makefile                        |   10 +
 lib/rspdm/consts.rs                       |  184 ++++
 lib/rspdm/lib.rs                          |  167 +++
 lib/rspdm/state.rs                        | 1202 +++++++++++++++++++++
 lib/rspdm/validator.rs                    |  545 ++++++++++
 rust/bindings/bindings_helper.h           |    5 +
 rust/helpers/hash.c                       |   18 +
 rust/helpers/helpers.c                    |    1 +
 rust/kernel/error.rs                      |   23 +-
 rust/kernel/lib.rs                        |    1 +
 rust/kernel/str.rs                        |   13 +-
 rust/kernel/transmute.rs                  |   59 +
 rust/kernel/validate.rs                   |  216 ++++
 33 files changed, 3008 insertions(+), 124 deletions(-)
 create mode 100644 drivers/pci/cma.asn1
 create mode 100644 drivers/pci/cma.c
 create mode 100644 include/keys/x509-parser.h
 create mode 100644 include/linux/spdm.h
 create mode 100644 lib/rspdm/Makefile
 create mode 100644 lib/rspdm/consts.rs
 create mode 100644 lib/rspdm/lib.rs
 create mode 100644 lib/rspdm/state.rs
 create mode 100644 lib/rspdm/validator.rs
 create mode 100644 rust/helpers/hash.c
 create mode 100644 rust/kernel/validate.rs

-- 
2.54.0

