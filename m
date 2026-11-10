Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284438;
	b=AlzGFSSzq30Nl0qMiVlkBuT3Wid7pHY71fmlJSWe5LRLtm8+Nc5lkP/ZMxoQ0lraCpX0
	 UkwqxA9v0n44mqXRr7AUpB1h8eNMCCi3V0eIbG0xz0+chJQ4ELCcTbkyNprg6T5E33cme
	 82VzbC0Pi1vMcSozwt6lXV2F8UYB8ke9vwwiSB5LlXG/TLVk8Q0GUhSG8lzZpj4j4guum
	 inxtWmmNISEtWP7DZwTXd78rVXVIKctYqWowXqttikleBOgrLHkRcliF/Eq53e4w/0OF8
	 eF4w3+Uv3MkX0wxhcv56/SZbn1y9UGAY44GFFwcR/mBAbZxu44EV7CLLielXDxgPXSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0+RTFl5Qa5SW/ve8wTc5MHTqhyuBwC9vc+CWPhIbY0g=;
	b=qn0VOOi7NQazpS4v3SjLuu3WDbz0K52aM2NZvSoLwGch/SppIyJHdhHjzSltE6eePgry
	 SH7OJHq25B+JNibwonSE6Di4UuIjAR7flvUxvNiwZUSFka2SundLr/bTcgJPAO2qDng+s
	 XnORJr/TbhgvjOexsMWmFfA59BgoPIJqrB8nzvkzanx5+aehXZlU+xvpPPwUrAoxovoW9
	 dH9wPYLrnrP+Fiqqig+1cVPqlZ0qHjScJEQRXak6imiTQ8Hb5CG1wGWY2QCKI1RTwDsGg
	 fvIJ2AyBYS/+FImnV4ksArt8qePB2k9dBcR9R23Ulu5WKxE86lzhgF4Xi+bqpbn7tVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uQrAU7FI;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7F2606A9EA
	for <linux-cxl@vger.kernel.org>; Tue, 10 Nov 2026 04:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E7F2606A9EA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uQrAU7FI
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1ae58d17cd9so1156493c88.1
        for <linux-cxl@vger.kernel.org>; Mon, 09 Nov 2026 20:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284436; x=1794889236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0+RTFl5Qa5SW/ve8wTc5MHTqhyuBwC9vc+CWPhIbY0g=;
        b=uQrAU7FIjpA3+uQiScnpVcbqhV/fu+xSO2mQbPWaqRBfvBGwZWu/6D+WaJdkY05uTi
         6SFVkl6S+QDaVfZHSSbi2/NOssUUNW7jjEwDnkEDeeyG1oIGIjIe7Cc8CbZhjMsyafr4
         Dd6QV4JTceiZIdIzdOHZtnkU/M3nAqw1Lfs94a42LvQFbidf1ROO9+y2UvJNspoc6Nd2
         2AILZ6KfpnnkGRo5y1cSXeC6DhgknFpPx3GjwLtWdOazGEKPznvWQpcmLsgJmyvY9aDq
         XasTIIIm3GFkX6/V5Ob+dJ8q9IvoyLNzdBabLy+Q1fpVZMN9ge9tSj5if2YV846WsPE/
         LK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284436; x=1794889236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0+RTFl5Qa5SW/ve8wTc5MHTqhyuBwC9vc+CWPhIbY0g=;
        b=WcxfZzp/AW9ICEVTaMNl7jA8yagOaY4G5ysb1aKQI+vz8lDTT97K0R2W/Ehyl1zI3z
         Aw4M+3QhtsxS9ahJg1+WpNayuNhwq2aHMcMiGISmfKbhHfdD44e2w6RKUFkc2QYF6jqp
         ia4OQ3FWjNGky5Q0eAjNhFrYj1cGpvRDQtU5Rcx4lOKpBA5iVAKnJJeAgh6ukbQN8OdB
         Zh8PHl75kYfWLvYq4mfZMPBlqRu7K1qEGAP8G8ev4fhdk35DmlTFrqewLQSLusmzy4u4
         aCERnu/gIhw3s2Zlpr5Bl8uFiEftcdS2c34bBOP2At599vbMJ0f0UrfP/kRVSYyKVJN9
         gpiw==
X-Forwarded-Encrypted: i=1; AL+hErH4vwWe44CiZwcbK3S213MrJruXoQ1sIkCD5t7c0SS2chCcQa+y0pVQUeGWZKZa+KR2knQYWu80CM8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1TibeT/u2YFbkaYb4yOP4mtjxD574GZkLZERY7Z21/6/AyFTV
	AGWMPGF6pl9MSWMiOHXwssJAQF1FCJndMZ7aNyNyAGu/xoXKx4oMpl0U
X-Gm-Gg: AYBFou0dUKHHTYngtVYR31XATSC5CdC5Ki93UfJla0jg1p3V3vEhvAf+0EqLLKQMWfP
	ArTXmOfilu7yqkc0YNhDP2tcaCrUvqSCmAMStING5L+JdMsiUTj5lt+c9PGvmreYdmAi3rdxw2k
	T6ntKDEh4emfdQtW+9+E9oy9GcYjd9L9Mcg4CNLFrWc3UZK5Gr9pU8X3Ui4kmoy1fi98I5vuR4q
	oM88f3cb8V0ESOpbhsEpkSmm0KmSP9Vq94yQeLxV85XD9hXzvk5QMHR9Oh/LLslGlKeI+/5Xi3Y
	q00eWW+LWMKt+w4GexTaV2CSupXvkHOaoFdhA+jD8VG3TNzv/6uFsZFK5opSdghUx7QFqOzN2e6
	Gpp7iHCQbVSPh6HBP3/O8nEywIZcG63gyA0pWaqpPBWkjpC+LaBQ2UM3aQ9snKBtpsgev/3tbNA
	DWGoVHyGoUiY/8A7c3ppT3OGbfhkBjbtb5wj2xCk8CKrDnh2v0HYB8ShIKxfEdZsT6WwHZlZzvG
	ADjOBUQqd9HitU7Kjuk3DNNcqR1HnTCsYgyO+d6JRtoJePKbjLIj6J/ZMXnhC2ij9IKLzLTlVki
	FABCeIafhVoMdC/AUcVOYPHSKFD2GTnfG3YY4A0KmMgc7Z8=
X-Received: by 2002:a05:7022:3f0e:b0:1a3:dbb2:478a with SMTP id a92af1059eb24-1b3b600f2e9mr2183556c88.27.1794284436124;
        Mon, 09 Nov 2026 20:20:36 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:20:35 -0800 (PST)
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 13/25] PCI/CMA: Validate Subject Alternative Name in certificates
Date: Tue, 10 Nov 2026 14:18:20 +1000
Message-ID: <20261110041832.1730924-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110041832.1730924-1-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
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
index 0000000000000..bbc998c4e31be
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
+	x400Address			[3] IMPLICIT SEQUENCE OF ANY,
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
index 3f0c989b52c5d..2c4c35bda4646 100644
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
+			    const struct x509_certificate *leaf_cert)
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

