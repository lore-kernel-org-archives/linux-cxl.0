Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078846;
	b=bj5iGChxc0lSVoWnRBDbs/n4KhQsotxKvoEbu3slKw1XbWAEZdMNtGrTTVirJp7r4zQz
	 OIpUNGplj1WnXIj4hMgYrN9z5gyFlLZwJgGfmWt9b3UwCkczY86ksCiAemqgyZJdGTbmr
	 pX1K10oZ/0VjoRwDSX4YsPDoPZcxryUpD+CptSQkAAjt49MnKztzGkjAwcD5wtGIZbQPi
	 uEs4oM3Q5Jt+flaZBcNldjX4f436hpcyKnxw/gss21JyLeXNRDYmy+KGx5Q7+q1xUL77o
	 zfKmry0eR/seMl6y+hZS1fljqafU3fAIskwn5DGtabOLuqZFEWcXVCaKTGoiJbi+E0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078846;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FqVJ1gPKY5+BJSRRLjzl6HJHWWh1tOBfq4LLwLS3vcE=;
	b=jPcCP5/02A5jpsvZFAHRLMjbaPKDy5AIEzdSkEIRDAyQF0Ffm3rt0GDl3k/sM/+VY0if
	 TWGeVDtb/t3ys9NSY1zrGQm54JwO6glXuembB0oRv5bW7hNqJnf6blpCsqD5wTTGofEU9
	 GnzvRIOiEwPQWK6OJutRQ0O/XTFWroHu9eCKSraSvnEw4RctZPUtKLnDwI2LHsOK0cM7+
	 RaIjloifIWYmXeL2z8Na0foh9HaBAbpoxx01Lu4SrcWtRWgEVhmmj2RpLpFEU0wnkt3NO
	 sfmBWgdF4AgPb9T8Y9DF5s0Sqzpun+5r8xX9nvZTV/nxJdx7Ug678cYsOml9qqLCBpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VIK6jd24;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4971C606A31E
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 05:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4971C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VIK6jd24
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e5fb79ce82so23684645ad.0
        for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 22:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078845; x=1793683645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FqVJ1gPKY5+BJSRRLjzl6HJHWWh1tOBfq4LLwLS3vcE=;
        b=VIK6jd24+Jt16Oaqz82qAbmkkoomQuXEW4xp/hAQ6qm0k7JbJCbyQa6ZWFGInyi/Rk
         Ps68DHx+hzCu1P7Rbkzfeu+4F7na+DKs6ZthYaJ3uxEyp+1hOxiUGUwrTz1iW781Q2Wz
         lD4pswPzvmG42OQziyej5Cdtec4AAw8HezqwuCHDo6FH+xUm/tVa7v5zS7anBc+Rk0fv
         oCrglDsJeh0a0xIDpFykSMS7qhYMVS5TVT2it1Vz/w38AeS1K9ypYz8AHmALHuBONQsf
         VKr50Bp8wLyHji5fJ1jm7LM05ZnOfednb/crjglhv0wRAGlIp+Vp6kntHbtIvQxV2UvJ
         JTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078845; x=1793683645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FqVJ1gPKY5+BJSRRLjzl6HJHWWh1tOBfq4LLwLS3vcE=;
        b=kmXXmdOtyCsuyqF9HNs12BP9hAxr1nJVZH4kYyBmajp0V0y5KblzV8PBq2ySW9byxg
         ukUy1ZxFIM8pAZJ8JT8hJQ75J2008xZRmw7gKJJdPMCrGzMlELeCEckzlmH3nYZdMm11
         OKFKZgs/0qYQFMswNC3aQMHP6rdDDqdMde3R53SiHKaIDSu2+Vn7i8WbObXl6ydoQAHy
         vGeFMtHJg1w4pPQO8orA5+BXjiparsl9+hWqkvwASteC9daLnKHyy5qIkAyIW2f7MGzM
         rOfcsrX3id4+jYbspSZY1gcv7freNKsj9qDri7aEKhVQO+QeLUJZhcdBcG+nrR/MSclr
         zztA==
X-Forwarded-Encrypted: i=1; AKwUvByBZcL4iTw/DIb8T7WYH80Ey6xSstQ4BTkANBGWyCWhkJt83fnlqvRZQD6s7HqxqbJgOGe38XuHCQg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJoJEbTDDTmcqnSzDaMwpRm/xmUUjpdIssxuKyOkr705tWJHN2E
	BRWxBO1tRqHcB0p4LUMjFYajqT9zeNxhA1D6QpiH1t2dAq8m+z6QAaIsW7F9SA==
X-Gm-Gg: AYBFou0pKZyjIOacMqhAD68kFompKrwhAw2ZZ3Ug2iJtxtAj/9hhiXVGKYuk3gUSWMJ
	Jo259GhZG4/4NyPc2CmKnpuUw1topcLNzH6bCcYpT61tXbnqPlkmJki+ykiVSQGwOxVnbtgEGZU
	vvkUrO2JUI4lEsRLeS5aM8lVwtnd67iPv1vxDMCbg9MVxWW0U+rT4u4wvXbLhYYGcj9zUt2mvun
	2tx0j70QmEK6kr1Vg/9sj30b2BUbKPFBaLflOgP7ddr4PJaQiA3jVcU6ROybHyHuMG5FmdXD79R
	SFuRzTDMjR5GgCYZo8PM9gKMmk4NhT72JzzlBsMa3P+zpqpnTVEjBtJd/CQH5l+xY5rQpUQV766
	7pvfTtj1zP2uUKFBpO0p9btLrJ+OOVi+mlisx6MywBY1WUP5O8h5VvAd2LdL7jja8fKNa7QlVDB
	KPTBOd1xiw7am5FqeDVa188Ahu2/iG4OYFm7KWlox0UvMHpNoibj6xdz8ovcsE94pUGygroGfBa
	sOagWPoJC4sUnivP7Wa8eJJdi/8pMH8LEgwgE62BjCUyNrgUNUDkAYyf4kgE+fJbuFqlUsimg==
X-Received: by 2002:a17:903:19c7:b0:2e9:7ff5:5459 with SMTP id d9443c01a7336-2ea9c6c3337mr76173565ad.15.1793078844630;
        Mon, 26 Oct 2026 22:27:24 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:27:23 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	alistair@alistair23.me,
	rust-for-linux@vger.kernel.org,
	jic23@kernel.org
Cc: ojeda@kernel.org,
	aliceryhl@google.com,
	a.hindborg@kernel.org,
	alistair23@gmail.com,
	wilfred.mallawa@wdc.com,
	bjorn3_gh@protonmail.com,
	gregkh@linuxfoundation.org,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	gary@garyguo.net,
	tmgross@umich.edu,
	alex.gaynor@gmail.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 13/23] PCI/CMA: Validate Subject Alternative Name in certificates
Date: Tue, 27 Oct 2026 15:25:26 +1000
Message-ID: <20261027052536.1722081-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027052536.1722081-1-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

PCIe r6.1 sec 6.31.3 stipulates requirements for Leaf Certificates
presented by devices, in particular the presence of a Subject Alternative
Name which encodes the Vendor ID, Device ID, Device Serial Number, etc.

This prevents a mismatch between the device identity in Config Space and
the certificate.  A device cannot misappropriate a certificate from a
different device without also spoofing Config Space.  As a corollary,
it cannot dupe an arbitrary driver into binding to it.  Only drivers
which bind to the device identity in the Subject Alternative Name work
(PCIe r6.1 sec 6.31 "Implementation Note: Overview of Threat Model").

The Subject Alternative Name is signed, hence constitutes a signed copy
of a Config Space portion.  It's the same concept as web certificates
which contain a set of domain names in the Subject Alternative Name for
identity verification.

Parse the Subject Alternative Name using a small ASN.1 module and
validate its contents.  The theory of operation is explained in a
comment at the top of the newly inserted code.

This functionality is introduced in a separate commit on top of basic
CMA-SPDM support to split the code into digestible, reviewable chunks.

The CMA OID added here is taken from the official OID Repository
(it's not documented in the PCIe Base Spec):
https://oid-rep.orange-labs.fr/get/2.23.147

Side notes:

* PCIe r6.2 removes the spec language on the Subject Alternative Name.
  It still "requires the leaf certificate to include the information
  typically used by system software for device driver binding", but no
  longer specifies how that information is encoded into the certificate.

  According to the editor of the PCIe Base Spec and the author of the
  CMA 1.1 ECN (which caused this change), FPGA cards which mutate their
  device identity at runtime (due to a firmware update) were thought as
  unable to satisfy the previous spec language.  The Protocol Working
  Group could not agree on a better solution and therefore dropped the
  spec language entirely.  They acknowledge that the requirement is now
  under-spec'd.  Because products already exist which adhere to the
  Subject Alternative Name requirement per PCIe r6.1 sec 6.31.3, they
  recommended to "push through" and use it as the de facto standard.

  The FPGA concerns are easily overcome by reauthenticating the device
  after a firmware update, either via sysfs or pci_cma_reauthenticate()
  (added by a subsequent commit).

* PCIe r6.1 sec 6.31.3 strongly recommends to verify that "the
  information provided in the Subject Alternative Name entry is signed
  by the vendor indicated by the Vendor ID."  In other words, the root
  certificate on pci_cma_keyring which signs the device's certificate
  chain must have been created for a particular Vendor ID.

  Unfortunately the spec neglects to define how the Vendor ID shall be
  encoded into the root certificate.  So the recommendation cannot be
  implemented at this point and it is thus possible that a vendor signs
  device certificates of a different vendor.

* Instead of a Subject Alternative Name, Leaf Certificates may include
  "a Reference Integrity Manifest, e.g., see Trusted Computing Group" or
  "a pointer to a location where such a Reference Integrity Manifest can
  be obtained" (PCIe r6.1 sec 6.31.3).

  A Reference Integrity Manifest contains "golden" measurements which
  can be compared to actual measurements retrieved from a device.
  It serves a different purpose than the Subject Alternative Name,
  hence it is unclear why the spec says only either of them is necessary.
  It is also unclear how a Reference Integrity Manifest shall be encoded
  into a certificate.

  Hence ignore the Reference Integrity Manifest requirement.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # except ASN.1
[ Changed by AF:
 - Fixup a few issues caught by Sashiko
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/pci/Makefile         |   5 +-
 drivers/pci/cma.asn1         |  41 ++++++++++++
 drivers/pci/cma.c            | 123 ++++++++++++++++++++++++++++++++++-
 include/linux/oid_registry.h |   3 +
 4 files changed, 170 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/cma.asn1

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 16abfd0e17e19..882cbb1083646 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -41,7 +41,10 @@ obj-$(CONFIG_PCI_NPEM)		+= npem.o
 obj-$(CONFIG_PCIE_TPH)		+= tph.o
 obj-$(CONFIG_CARDBUS)		+= setup-cardbus.o
 
-obj-$(CONFIG_PCI_CMA)		+= cma.o
+obj-$(CONFIG_PCI_CMA)		+= pci-cma.o
+pci-cma-y			:= cma.o cma.asn1.o
+$(obj)/cma.o:			$(obj)/cma.asn1.h
+$(obj)/cma.asn1.o:		$(obj)/cma.asn1.c $(obj)/cma.asn1.h
 
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
diff --git a/drivers/pci/cma.asn1 b/drivers/pci/cma.asn1
new file mode 100644
index 0000000000000..da41421d40856
--- /dev/null
+++ b/drivers/pci/cma.asn1
@@ -0,0 +1,41 @@
+-- SPDX-License-Identifier: BSD-3-Clause
+--
+-- Component Measurement and Authentication (CMA-SPDM, PCIe r6.1 sec 6.31.3)
+-- X.509 Subject Alternative Name (RFC 5280 sec 4.2.1.6)
+--
+-- Copyright (C) 2008 IETF Trust and the persons identified as authors
+-- of the code
+--
+-- https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.6
+--
+-- The ASN.1 module in RFC 5280 appendix A.1 uses EXPLICIT TAGS whereas the one
+-- in appendix A.2 uses IMPLICIT TAGS.  The kernel's simplified asn1_compiler.c
+-- always uses EXPLICIT TAGS, hence this ASN.1 module differs from RFC 5280 in
+-- that it adds IMPLICIT to definitions from appendix A.2 (such as GeneralName)
+-- and omits EXPLICIT in those definitions.
+
+SubjectAltName ::= GeneralNames
+
+GeneralNames ::= SEQUENCE OF GeneralName
+
+GeneralName ::= CHOICE {
+	otherName			[0] IMPLICIT OtherName,
+	rfc822Name			[1] IMPLICIT IA5String,
+	dNSName				[2] IMPLICIT IA5String,
+	x400Address			[3] ANY,
+	directoryName			[4] ANY,
+	ediPartyName			[5] IMPLICIT EDIPartyName,
+	uniformResourceIdentifier	[6] IMPLICIT IA5String,
+	iPAddress			[7] IMPLICIT OCTET STRING,
+	registeredID			[8] IMPLICIT OBJECT IDENTIFIER
+	}
+
+OtherName ::= SEQUENCE {
+	type-id			OBJECT IDENTIFIER ({ pci_cma_note_oid }),
+	value			[0] ANY ({ pci_cma_note_san })
+	}
+
+EDIPartyName ::= SEQUENCE {
+	nameAssigner		[0] ANY OPTIONAL,
+	partyName		[1] ANY
+	}
diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
index 6b52b129574ec..6e4eb3b921131 100644
--- a/drivers/pci/cma.c
+++ b/drivers/pci/cma.c
@@ -12,6 +12,9 @@
 #define dev_fmt(fmt) "CMA: " fmt
 
 #include <linux/err.h>
+#include <keys/x509-parser.h>
+#include <linux/asn1_decoder.h>
+#include <linux/oid_registry.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/pci-tsm.h>
@@ -20,8 +23,126 @@
 #include <linux/spdm.h>
 #include <linux/tsm.h>
 
+#include "cma.asn1.h"
 #include "pci.h"
 
+/*
+ * The spdm_requester.c library calls pci_cma_validate() to check requirements
+ * for Leaf Certificates per PCIe r6.1 sec 6.31.3.
+ *
+ * pci_cma_validate() parses the Subject Alternative Name using the ASN.1
+ * module cma.asn1, which calls pci_cma_note_oid() and pci_cma_note_san()
+ * to compare an OtherName against the expected name.
+ *
+ * The expected name is constructed beforehand by pci_cma_construct_san().
+ *
+ * PCIe r6.2 drops the Subject Alternative Name spec language, even though
+ * it continues to require "the leaf certificate to include the information
+ * typically used by system software for device driver binding".  Use the
+ * Subject Alternative Name per PCIe r6.1 for lack of a replacement and
+ * because it is the de facto standard among existing products.
+ */
+#define CMA_NAME_MAX sizeof("Vendor=1234:Device=1234:CC=123456:"	  \
+			    "REV=12:SSVID=1234:SSID=1234:1234567890123456")
+
+struct pci_cma_x509_context {
+	struct pci_dev *pdev;
+	u8 slot;
+	enum OID last_oid;
+	char expected_name[CMA_NAME_MAX];
+	unsigned int expected_len;
+	unsigned int found:1;
+};
+
+int pci_cma_note_oid(void *context, size_t hdrlen, unsigned char tag,
+		     const void *value, size_t vlen)
+{
+	struct pci_cma_x509_context *ctx = context;
+
+	ctx->last_oid = look_up_OID(value, vlen);
+
+	return 0;
+}
+
+int pci_cma_note_san(void *context, size_t hdrlen, unsigned char tag,
+		     const void *value, size_t vlen)
+{
+	struct pci_cma_x509_context *ctx = context;
+
+	/* These aren't the drOIDs we're looking for. */
+	if (ctx->last_oid != OID_CMA)
+		return 0;
+
+	if (tag != ASN1_UTF8STR ||
+	    vlen != ctx->expected_len ||
+	    memcmp(value, ctx->expected_name, vlen) != 0) {
+		pci_err(ctx->pdev, "Leaf certificate of slot %u "
+			"has invalid Subject Alternative Name\n", ctx->slot);
+		return -EINVAL;
+	}
+
+	ctx->found = true;
+
+	return 0;
+}
+
+static unsigned int pci_cma_construct_san(struct pci_dev *pdev, char *name)
+{
+	unsigned int len;
+	u64 serial;
+
+	len = scnprintf(name, CMA_NAME_MAX,
+			"Vendor=%04hx:Device=%04hx:CC=%06x:REV=%02hhx",
+			pdev->vendor, pdev->device, pdev->class, pdev->revision);
+
+	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL)
+		len += scnprintf(name + len, CMA_NAME_MAX - len,
+				 ":SSVID=%04hx:SSID=%04hx",
+				 pdev->subsystem_vendor, pdev->subsystem_device);
+
+	serial = pci_get_dsn(pdev);
+	if (serial)
+		len += scnprintf(name + len, CMA_NAME_MAX - len,
+				 ":%016llx", serial);
+
+	return len;
+}
+
+static int pci_cma_validate(struct device *dev, u8 slot,
+			    struct x509_certificate *leaf_cert)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_cma_x509_context ctx;
+	int ret;
+
+	if (!leaf_cert->raw_san) {
+		pci_err(pdev, "Leaf certificate of slot %u "
+			"has no Subject Alternative Name\n", slot);
+		return -EINVAL;
+	}
+
+	ctx.pdev = pdev;
+	ctx.slot = slot;
+	ctx.found = false;
+	ctx.expected_len = pci_cma_construct_san(pdev, ctx.expected_name);
+
+	ret = asn1_ber_decoder(&cma_decoder, &ctx, leaf_cert->raw_san,
+			       leaf_cert->raw_san_size);
+	if (ret == -EBADMSG || ret == -EMSGSIZE)
+		pci_err(pdev, "Leaf certificate of slot %u "
+			"has malformed Subject Alternative Name\n", slot);
+	if (ret < 0)
+		return ret;
+
+	if (!ctx.found) {
+		pci_err(pdev, "Leaf certificate of slot %u "
+			"has no OtherName with CMA OID\n", slot);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int pci_doe_transport(void *priv, struct device *dev,
 			     const void *request, size_t request_sz,
 			     void *response, size_t response_sz)
@@ -64,7 +185,7 @@ static struct pci_tsm *pci_cma_tsm_probe(struct tsm_dev *tsm_dev,
 	}
 
 	cma->spdm = spdm_create(&pdev->dev, pci_doe_transport, cma->host.doe_mb,
-				PCI_DOE_MAX_PAYLOAD, NULL);
+				PCI_DOE_MAX_PAYLOAD, pci_cma_validate);
 	if (!cma->spdm) {
 		pci_tsm_host_destructor(&cma->host);
 		kfree(cma);
diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index ebce402854de4..113f4e802ec40 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -150,6 +150,9 @@ enum OID {
 	OID_id_ml_dsa_65,			/* 2.16.840.1.101.3.4.3.18 */
 	OID_id_ml_dsa_87,			/* 2.16.840.1.101.3.4.3.19 */
 
+	/* PCI */
+	OID_CMA,			/* 2.23.147 */
+
 	OID__NR
 };
 
-- 
2.56.0

