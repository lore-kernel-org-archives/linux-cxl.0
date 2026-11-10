Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284326;
	b=KfQEYL9M3hmg3vUnejDSl37WPqtY7WWPRN0OSL8+NozVJLCFhWRehKjGswL+YEtxox7B
	 LZITJw5uVfSOnJx1xOE6iofhyie2oNttxiZbh8Oj9jG+QMJ9Xdd9g+GcCrysNI+2D9Ron
	 g9ZayRRkiteBReWoRW40TKIUp5pWYArZJtof1aa3k4FWG+GqAUIka61w2oBi2tIUDe+Np
	 V54k0KExxkGMWkcghguHt4WiJq/OcU9CrKtQxbczpwwZDYiV3RPpCAII6DoFGWX/uIktT
	 4RCi8WmIkjIlmehSvbjQrZlmdcV39suByaWz3uNZ2i6Z2oZRQ0zyn8XBgZ6gDIS100w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Ywbh2lEyTcpQxsowWo8XEkNgOvkD1AiYRUBcCIG+9aA=;
	b=CQwNIjetQnbAE5mu/ckqx6h0g3pmvMB8Nd6hC5sLOCcER4ivES+4mwsxycFcT81gQK9s
	 zJ8g4/g9SFRUDAEAO8yYFWzuTRahR40kMDiUWynObiLHB1gt/Ajm+BFSJyGk+8qwdgaid
	 F68+3wm3I+3GAiuo6LdL2b6PD6TOYiOR+ssgGZspwVEedd0JfGluM0AqRVpwmjD51F9xh
	 cvbG49XR4/eX7nbfOAF/14qAj4RfA5yArR+DyW7rSSUhUtI2odoSSnkp/x8w95mnkS9no
	 lbCHsK9s0sNym65MZn//P/g7oppNO2sNFgF6d4DtRBBZePd1n0g0KxQL/1an4O2pxuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0m+3ices;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5F2606A332
	for <linux-cxl@vger.kernel.org>; Tue, 10 Nov 2026 04:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F5F2606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0m+3ices
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b3acec6677so2337961c88.1
        for <linux-cxl@vger.kernel.org>; Mon, 09 Nov 2026 20:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284324; x=1794889124; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ywbh2lEyTcpQxsowWo8XEkNgOvkD1AiYRUBcCIG+9aA=;
        b=0m+3icese11IhSMQal2EJxNJfKJ4k6gxX07pR73T4cNv+FOX0i2KgW3AlWl6pOLICZ
         fA2xrJ607pNEP+FLRxfMDGomuVoMRkdyGw6gGM9Z5w8SgNyuAgka273Ozkjir/o2nXmm
         KK/k9dvF1urNzmPTnpB6KcgDyQyOnM8g4e2LTLcGSs6xccWYBZCUAD8dg1TsiayGa/CP
         d56hMRaI/nx9PH8IY/RSFj9oKf4DQi61HMGJ/Y0sTKrpzN7B1WgWhOAmjNTNaFavdR3k
         W8cPRTq6xLSCrGoVwpIBLwruQBvEsUovZQ9yXkvNI4/T2qnvWMipsttJdUDtJRK6LM4d
         BYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284324; x=1794889124;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ywbh2lEyTcpQxsowWo8XEkNgOvkD1AiYRUBcCIG+9aA=;
        b=CnrVoYapsL+Agl0CVa/OIlJt5ALYQPReosQtsDcyvcvchwla0Uu1npeDq0jwQRqUdt
         fX2x+cZt43Z08amHfXLPbyKthyYhrrs7ogHTZ3oDqs0TQK9OJN38pEL5H0hDLs/2CJ6d
         PqP4WAOuxjHDEwDkEVh19NHn1oWF51x43IV3bz5ce1zJI1wQw4S+N2f3Kd9xuW/MEB5i
         s5iVWShP53LdDL0elRxdiXFSYYcr60eRmMjYt4i75faJIOczk+drJ+KSVEiOgxcgJ81G
         afDjKx1k2pYuqmYyav87m7qBXqYrsckBtQyNdHAOg3HpQGMuidj6jNCtYAS3+BBoi/vi
         ejeQ==
X-Forwarded-Encrypted: i=1; AL+hErGcjvXuu2B3rcmdMIkZLssW4qbh1YmhvBuKYxxfCzMe6yojwRWG5LBTlambSU7y8dNas0kyAJ6+oMU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8l2kdZlDftWclWN2xYTIL/flMYojy1x5xMJGh4gpoTMA6et+bt
	4PKg7/f8AkO00KJW7fitOn33P1e+B7rPCK+NvfLOPu8IWpDGlOjcnYw+
X-Gm-Gg: AYBFou0W8VPIBo8WD176LeMRRSzROVTR2mPBMQuAYyEBWNjXJ4k43cg7vP1KGJjfnFZ
	u2s+/W2fWGKlEoftNyfY4yK9uANMgWGipLiIkpI3Q8EgcSK+Bzr+DXsia5HDyIGsZMJC2SliOzv
	Givi2yFHgcSG7ESTTS480CyIwlQ7X/hFWP6s/W4DqN01jqTPpwHMmx4+3yLZM4adQcU++4U8TfB
	/U8Fi/RoJs4wLGcHzYOGPjb3K7kQAni3UVwKeFneM3/0zt0UGnkJ16IPhG+0571qCsgQCya8m2d
	k/krlYd6v9yp62ooVV/VHCKTfLTj9/aO4WgT8mO14MhYxq8d+AVpKhVjpm85yJ6Hgl+06JP98Y3
	Dwddno5B1+3AnyF1j/qVCSvdrms3t5E3bnpOJLbOg38jK2XiNsFUrcXdMgph3FA3i+74IUPAq/x
	z66gdu6WW3FB252dxyNQVOUzN/nyeBP0u3RuP+siUQ3bX5J8DGUrYFUeUFx+hMpVMfTNmnXl34v
	fJ0T09PjVG3/xWwPKVB7SIdMJsD5B3Y+FCWoMONg1dSCAmRjIOoqHMy2SVH0I3E8MIJdMx/vDHD
	1qu1Dsf5qp5Jx8YYYi+Z6qth+12swfpojZ14r4N51onMQ9I=
X-Received: by 2002:a05:7022:3b82:b0:1b2:366a:e7d1 with SMTP id a92af1059eb24-1b3b6182c6bmr1995819c88.32.1794284323891;
        Mon, 09 Nov 2026 20:18:43 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:18:43 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: bhelgaas@google.com,
	lukas@wunner.de,
	bvanassche@acm.org,
	linux-pci@vger.kernel.org,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	rust-for-linux@vger.kernel.org,
	jgg@nvidia.com,
	akpm@linux-foundation.org
Cc: gary@garyguo.net,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	boqun.feng@gmail.com,
	alistair23@gmail.com,
	gregkh@linuxfoundation.org,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	alex.gaynor@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 00/25] lib: Rust implementation of SPDM
Date: Tue, 10 Nov 2026 14:18:07 +1000
Message-ID: <20261110041832.1730924-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
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

This is done using the `Validate` and `Untrusted` traits. The `validate()`
function has been updated updated to allow `context` which we use as
part of the validation.

The validation has also swapped from a C style pointer cast to using a valid
Rust struct and copying the data from the original buffer to the new struct.
This obvious has some overhead, but as SPDM packets are relativly small, and
not used as part of a constant hot path this seems fine. The big advantage is
that we can validate everyting at once, convert the endianess when creating
the struct and we get left with valid (not repr[c, packed]) Rust structs.

This makes the code a lot cleaner and more robust. It also removes a large
number of `unsafe`s and using `get()` for the arrays removes a large number
of possible `panic`s. Thanks for everyone at Kangrejos for the help with this!

This series also adds the required Rust Crypto bindings for SPDM.

I have kept Jonathon's reviews of the SPDM code, as the changes since the
last vesion are mostly just mechanical, convertting the repr[c, packed] structs
to copy structs.

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
  -device pcie-root-port,chassis=1,id=pci.1 \
  -device nvme,drive=mynvme,serial=deadbeef,spdm_port=2323,spdm_trans=doe,bus=pci.1 \
  -snapshot \
  -serial mon:stdio -serial null -nographic \
  -kernel deploy/images/qemux86-64/bzImage \
  -append 'root=/dev/vda rw  console=ttyS0 console=ttyS1 oprofile.timer=1 tsc=reliable no_timer_check rcupdate.rcu_expedited=1 swiotlb=0 '

echo tsm0 > /sys/bus/pci/devices/0000:01:00.0/tsm/connect
```

1: https://www.dmtf.org/standards/spdm
2: https://lore.kernel.org/all/cover.1719771133.git.lukas@wunner.de/
3: http://lore.kernel.org/69976d7d39c60_2f4a1009@dwillia2-mobl4.notmuch
4: https://lore.kernel.org/all/69976d7d39c60_2f4a1009@dwillia2-mobl4.notmuch/
5: https://lore.kernel.org/lkml/69e19c80b892b_fe0831000@djbw-dev.notmuch/

v6:
 - Add crypto bindings
 - Expose public Rust API
 - Address LLM generated reviews
v5:
 - Split out crypto into Rust kernel wrappers
 - Use ZeroCopy for SpdmHeader
 - Add the Transport trait and CTransport type
 - Bind the device driver
 - Address bugs and issues from reviews
v4:
 - Based on discussions at Kangrejos the following changes were made
     - Add context to the validate functions
     - Convert the validate() functions to be complete Rust structs and copy the
       data, instead of C style pointer casts
     - Use ForeignOwnable trait for SpdmState
     - Use get() for array accesses
 - Address review comments
v3:
 - Rebase on 7.3-rc1
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

Alistair Francis (19):
  virt: coco: change tsm_register() to use a const struct
  rust: add bindings for hash.h
  rust: device: Expose Device as_raw() publicly
  lib: rspdm: Initial commit of Rust SPDM
  PCI/TSM: Rename pf0 to host
  PCI/TSM: Support connecting to PCIe CMA devices
  PCI/CMA: Add a PCI TSM CMA driver using SPDM
  lib: rspdm: Support SPDM get_version
  lib: rspdm: Support SPDM get_capabilities
  rust: kernel: Add crypto hash bindings
  lib: rspdm: Support SPDM negotiate_algorithms
  lib: rspdm: Support SPDM get_digests
  lib: rspdm: Support SPDM get_certificate
  rust: public_key: Add crypto public key bindings
  keys: Guard asymmetric-type.h behind CONFIG_KEYS
  rust: x509: Add X509 certificate bindings
  lib: rspdm: Support SPDM certificate validation
  lib: rspdm: Support SPDM challenge
  lib: rspdm: Expose public Rust API

Benno Lossin (2):
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
 drivers/crypto/ccp/sev-dev-tsm.c          |   14 +-
 drivers/pci/Kconfig                       |   14 +
 drivers/pci/Makefile                      |    5 +
 drivers/pci/cma.asn1                      |   41 +
 drivers/pci/cma.c                         |  271 +++++
 drivers/pci/doe.c                         |    6 +-
 drivers/pci/tsm.c                         |  185 ++--
 drivers/virt/coco/tsm-core.c              |    4 +-
 include/keys/asymmetric-type.h            |    5 +
 include/keys/x509-parser.h                |   57 ++
 include/linux/oid_registry.h              |    3 +
 include/linux/pci-doe.h                   |    4 +
 include/linux/pci-tsm.h                   |   48 +-
 include/linux/pci.h                       |    1 +
 include/linux/spdm.h                      |   71 ++
 include/linux/tsm.h                       |    2 +-
 lib/Kconfig                               |   18 +
 lib/Makefile                              |    2 +
 lib/rspdm/Makefile                        |   10 +
 lib/rspdm/consts.rs                       |  123 +++
 lib/rspdm/lib.rs                          |  317 ++++++
 lib/rspdm/state.rs                        | 1000 ++++++++++++++++++
 lib/rspdm/validator.rs                    | 1140 +++++++++++++++++++++
 rust/bindings/bindings_helper.h           |    5 +
 rust/helpers/hash.c                       |   22 +
 rust/helpers/helpers.c                    |    1 +
 rust/kernel/device.rs                     |    3 +-
 rust/kernel/hash.rs                       |  141 +++
 rust/kernel/lib.rs                        |    7 +
 rust/kernel/public_key.rs                 |   83 ++
 rust/kernel/validate.rs                   |  281 +++++
 rust/kernel/x509.rs                       |  236 +++++
 37 files changed, 4082 insertions(+), 144 deletions(-)
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
 create mode 100644 rust/kernel/hash.rs
 create mode 100644 rust/kernel/public_key.rs
 create mode 100644 rust/kernel/validate.rs
 create mode 100644 rust/kernel/x509.rs

-- 
2.56.0

