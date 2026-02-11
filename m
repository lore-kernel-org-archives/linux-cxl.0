Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28003254A9
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 03:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780588; cv=none; b=uCyj11tqQVy37vPH75L0kd59wfeKUb2DTs/XpessVhMiPF/tDmOQuC5MfnRZ0e00tWoDmNpHczUm4260C1zm/77SuSgbLfANQO1iRqzIlVhGXjy8xTCCnXTWeCvXd5cVFmL0n6i353imS9rbPwcBiRVLcX5xS55bPXC2ffRb/i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780588; c=relaxed/simple;
	bh=yjCYMr4/Y+sFjysrO3hYUEFgNcLVQAjXiBppSEz9dM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P8asTFCMmnBZnJO3kY7GiPmDOXH+qN7Gq6I0IupLfdiZ7op7NbP9gP9lMttvVNC+XtOhbiYm1CyoLfQaXrlgAZJ/3DqpCaL8I1wLDbQ614H3gn5Q3JX6WcVk8JulT/s2eVM5MIftVCd1HiioK0RpFO9u9oysKaWEJp97/gc3RBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtjTPCnP; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtjTPCnP"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c6e191c4b8fso113763a12.0
        for <linux-cxl@vger.kernel.org>; Tue, 10 Feb 2026 19:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780586; x=1771385386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A8YS3gRF2IPype2vr2baVtGMes0KUGXuUhrTuNPzbKQ=;
        b=RtjTPCnPrA+5JPiY8laIGgrbqHpCqoqBJOb5ykRqfSZidYMzrzGcL8Y3lFB2lkvvBr
         18pCt+8//2KMXRlqRDcUNY4HIJIL45poROUOGbMWOxwK0+53mqB/rACzimPIn7jenHjd
         nkRnHAFD+1KNSgwDLsgqX7tVHYW4r2CUBea6dIq+mtYHNYQvgMWYA8rJSX3/ZY1/wtED
         NG388m+Cac/BYty8qkZ3ISD4dE7JZYfpiwstYKXMZ/8Er69IrYNGY4qn05dYnUsuqLCo
         omMkrVemcEdPljK5FFT1sPTonNpgehDLDFAWHkO/t63q4HC15Ubm/pZBoMHFNaWfAIZk
         qenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780586; x=1771385386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8YS3gRF2IPype2vr2baVtGMes0KUGXuUhrTuNPzbKQ=;
        b=N4Sb22g3iv9ic+PIWlytLwmzqwb5oFkPHKw0clBwUgPTXPcUDJvSau46vpUWNebwbQ
         p61vDQYWanbLt+V8YaGa53h/3Ax8PS25BAF78a6nyjLdsdN/fk31Q+RT5zTBn0uWZt0a
         zOODYRV5UjlAE5MlUZuTZi/4wgStd/3tCQwVspSt4KpOcAbOXC/zWPL1553ib59i0YoR
         rdW3TD2jP7AtRMyJoBqsV/LqnhPZyQNWkuGvfscKT10O2coieL6fpeNV25KGnD0//uhA
         JIH9BmDG1eAiHEYI/VFntnS3XKkfHFiaI70OqIfCWjLJhw8V2WBATlxauEbBO23vG+e9
         BQMg==
X-Forwarded-Encrypted: i=1; AJvYcCXMsAHx+mLARk7+914DE1QrDAdUkwB44lSAZx8iSwmlxNj7KDbNHXlOQWUcaVO4J0cHN+XU+VVJbYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRlzOmNrwC/RIsMqjetSgesRYoSxjE+KG2vgLx7TfvUVYECLlv
	VtmHPORxTrvHe6iWHDshnXPXPGpA+xt7ks/tgeCdb+vmZniFIscdpYdB
X-Gm-Gg: AZuq6aJUrNwdAyn6JyWhFOnUu2sBl8WBRMb98CUt2Kz+5q+q/iPLBLML3Yov7Qx8AZt
	GPhTPp0qV+eRJxqp0Awq0afd5FYWPRgX0aOCRBtyDYy3tWxYF/qkkorOUf2+fhhEBCPAW2lVaLH
	jiwhGvlQlYXId8IZvgg/02Xz/Yf/HeRnPJwnkM3Yf4TZ44kASg0tYGxUMEmRaSB9D95J/C2nsSx
	DXBWxmlUXwUiv51tKPjMC9T6sg0oR9Eczfjl/5ZM2YzNwGfJw8ULSgBZYeX+jvTGtnIqy7nDAtJ
	yW1LCmjizptz/mag6U7v0YpvVOBg1GeG17sPxDUsXItYUNPzPUf8UzVtoIOwMPvb9CwixdcnIc4
	FBOqAW97925hZFDaFKNjXsMTaMxH5uUlELVbqlGL9jmUc/I7ofOXP53S3JVOTD6iRpNP7AcOnF8
	LHRV1/N3mNHLB2nRO3sOm1zGxCIXZQ4ElrEZd8bkQrlIbophw3AOdQ
X-Received: by 2002:a05:6a21:496:b0:38d:eb2e:d042 with SMTP id adf61e73a8af0-3942e69e31fmr1206075637.60.1770780586054;
        Tue, 10 Feb 2026 19:29:46 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:29:45 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: bhelgaas@google.com,
	lukas@wunner.de,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	ojeda@kernel.org,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC v3 00/27] lib: Rust implementation of SPDM
Date: Wed, 11 Feb 2026 13:29:07 +1000
Message-ID: <20260211032935.2705841-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
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

This is very similar to Lukas' implementation [2]. This series includes patches
and files from Lukas' C SPDM implementation, which isn't in mainline.

This is a standalone series and doesn't depend on Lukas' implementation.

To help with maintaining compatibility it's designed in a way to match Lukas'
design and the state struct stores the same information, although in a Rust
struct instead of the original C one.

This series exposes the data to userspace via netlink, with a single sysfs
atrribute to allow reauthentication.

All of the patches are included in the RFC, as it depends on some patches
that aren't upstream yet.

Now that Rust is no longer experimental I have picked this back up. If the
community is generally on board with a Rust implementation I can work on
sending a non-RFC version and push towards getting that merged.

The entire tree can be seen here: https://github.com/alistair23/linux/tree/alistair/spdm-rust

I'm testing the netlink data by running the following

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

spdm_utils identify &
sleep 1
echo re > /sys/devices/pci0000:00/0000:00:03.0/authenticated
while openssl x509 -noout -text; do :; done < ~/retrieved_slot_id0
```

1: https://www.dmtf.org/standards/spdm
2: https://lore.kernel.org/all/cover.1719771133.git.lukas@wunner.de/
3: https://github.com/l1k/linux/commits/spdm-future/
4: https://lore.kernel.org/rust-for-linux/20240925205244.873020-1-benno.lossin@proton.me/
5: https://lore.kernel.org/rust-for-linux/20250107035058.818539-1-alistair@alistair23.me/

v3:
 - Use netlink to send information to userspace
 - Don't autogenerate Rust helpers
v2:
 - Drop support for Rust and C implementations
 - Include patches from Lukas to reduce series deps
 - Large code cleanups based on more testing
 - Support support for authentication

Alistair Francis (18):
  rust: add bindings for hash.h
  rust: error: impl From<FromBytesWithNulError> for Kernel Error
  lib: rspdm: Initial commit of Rust SPDM
  lib: rspdm: Support SPDM get_version
  lib: rspdm: Support SPDM get_capabilities
  lib: rspdm: Support SPDM negotiate_algorithms
  lib: rspdm: Support SPDM get_digests
  lib: rspdm: Support SPDM get_certificate
  crypto: asymmetric_keys - Load certificate parsing early in boot
  KEYS: Load keyring and certificates early in boot
  PCI/CMA: Support built in X.509 certificates
  crypto: sha: Load early in boot
  crypto: ecdsa: Load early in boot
  lib: rspdm: Support SPDM certificate validation
  rust: allow extracting the buffer from a CString
  lib: rspdm: Support SPDM challenge
  PCI/CMA: Expose in sysfs whether devices are authenticated
  rust: add bindings for hash_info

Benno Lossin (1):
  rust: add untrusted data abstraction

Jonathan Cameron (1):
  PCI/CMA: Authenticate devices on enumeration

Lukas Wunner (7):
  X.509: Make certificate parser public
  X.509: Parse Subject Alternative Name in certificates
  X.509: Move certificate length retrieval into new helper
  certs: Create blacklist keyring earlier
  PCI/CMA: Validate Subject Alternative Name in certificates
  PCI/CMA: Reauthenticate devices on reset and resume
  rspdm: Multicast received signatures via netlink

 Documentation/ABI/testing/sysfs-devices-spdm |   31 +
 Documentation/netlink/specs/spdm.yaml        |  136 +++
 MAINTAINERS                                  |   14 +
 certs/blacklist.c                            |    4 +-
 certs/system_keyring.c                       |    8 +-
 crypto/asymmetric_keys/asymmetric_type.c     |    2 +-
 crypto/asymmetric_keys/x509_cert_parser.c    |    9 +
 crypto/asymmetric_keys/x509_loader.c         |   38 +-
 crypto/asymmetric_keys/x509_parser.h         |   42 +-
 crypto/asymmetric_keys/x509_public_key.c     |    2 +-
 crypto/ecdsa.c                               |    2 +-
 crypto/sha256.c                              |    2 +-
 crypto/sha3.c                                |    2 +-
 crypto/sha512.c                              |    2 +-
 drivers/pci/Kconfig                          |   16 +
 drivers/pci/Makefile                         |    4 +
 drivers/pci/cma.asn1                         |   41 +
 drivers/pci/cma.c                            |  269 +++++
 drivers/pci/doe.c                            |    5 +-
 drivers/pci/pci-driver.c                     |    1 +
 drivers/pci/pci-sysfs.c                      |    3 +
 drivers/pci/pci.c                            |   12 +-
 drivers/pci/pci.h                            |   15 +
 drivers/pci/pcie/err.c                       |    3 +
 drivers/pci/probe.c                          |    1 +
 drivers/pci/remove.c                         |    1 +
 include/keys/asymmetric-type.h               |    2 +
 include/keys/system_keyring.h                |    4 +
 include/keys/x509-parser.h                   |   57 +
 include/linux/oid_registry.h                 |    3 +
 include/linux/pci-doe.h                      |    4 +
 include/linux/pci.h                          |   16 +
 include/linux/spdm.h                         |   39 +
 include/uapi/linux/spdm_netlink.h            |   49 +
 lib/Kconfig                                  |   17 +
 lib/Makefile                                 |    2 +
 lib/rspdm/Makefile                           |   12 +
 lib/rspdm/consts.rs                          |  213 ++++
 lib/rspdm/lib.rs                             |  180 +++
 lib/rspdm/netlink-autogen.c                  |   33 +
 lib/rspdm/netlink-autogen.h                  |   22 +
 lib/rspdm/req-netlink.c                      |  197 ++++
 lib/rspdm/req-sysfs.c                        |   98 ++
 lib/rspdm/spdm.h                             |   45 +
 lib/rspdm/state.rs                           | 1093 ++++++++++++++++++
 lib/rspdm/sysfs.rs                           |   38 +
 lib/rspdm/validator.rs                       |  489 ++++++++
 rust/bindings/bindings_helper.h              |   11 +
 rust/helpers/hash.c                          |   18 +
 rust/helpers/hash_info.c                     |    8 +
 rust/helpers/helpers.c                       |    2 +
 rust/kernel/error.rs                         |   10 +
 rust/kernel/lib.rs                           |    1 +
 rust/kernel/str.rs                           |    5 +
 rust/kernel/validate.rs                      |  605 ++++++++++
 55 files changed, 3866 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-spdm
 create mode 100644 Documentation/netlink/specs/spdm.yaml
 create mode 100644 drivers/pci/cma.asn1
 create mode 100644 drivers/pci/cma.c
 create mode 100644 include/keys/x509-parser.h
 create mode 100644 include/linux/spdm.h
 create mode 100644 include/uapi/linux/spdm_netlink.h
 create mode 100644 lib/rspdm/Makefile
 create mode 100644 lib/rspdm/consts.rs
 create mode 100644 lib/rspdm/lib.rs
 create mode 100644 lib/rspdm/netlink-autogen.c
 create mode 100644 lib/rspdm/netlink-autogen.h
 create mode 100644 lib/rspdm/req-netlink.c
 create mode 100644 lib/rspdm/req-sysfs.c
 create mode 100644 lib/rspdm/spdm.h
 create mode 100644 lib/rspdm/state.rs
 create mode 100644 lib/rspdm/sysfs.rs
 create mode 100644 lib/rspdm/validator.rs
 create mode 100644 rust/helpers/hash.c
 create mode 100644 rust/helpers/hash_info.c
 create mode 100644 rust/kernel/validate.rs

-- 
2.52.0

