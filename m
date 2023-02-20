Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5E0C64EC4
	for <linux-cxl@archiver.kernel.org>; Mon, 20 Feb 2023 04:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjBTE4Q (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 19 Feb 2023 23:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjBTE4P (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 19 Feb 2023 23:56:15 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9356EB477
        for <linux-cxl@vger.kernel.org>; Sun, 19 Feb 2023 20:56:11 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230220045610epoutp016599141b634c2c4c7467a5e1964b6987~Fb3GiBAEE1209112091epoutp01L
        for <linux-cxl@vger.kernel.org>; Mon, 20 Feb 2023 04:56:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230220045610epoutp016599141b634c2c4c7467a5e1964b6987~Fb3GiBAEE1209112091epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676868970;
        bh=rnK2jF8fa2h5GKKaa2x/H8Jc+D90RT+sgHPrSoAXrsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bSWXyJ+sTWVDeqy+f8b2Z3KO3TPrClfihRXaSuqHrWQ7CbBMIunPtBO5nGAF1lrrc
         w+n2TG3iimRjMSlmxZYpwuuW7n3uJllrt+VjgUwt31dCiPCNBt9rK3EfTqIXYmBzsO
         N7W2VJiGyepN5FZiERVLVrHKNTcq/KuHKSvNgxGE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230220045609epcas2p2a22275931c28fc18e6a08f6d8e25d432~Fb3GNFfrs1751717517epcas2p2K;
        Mon, 20 Feb 2023 04:56:09 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.98]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PKqr91Xr9z4x9Q1; Mon, 20 Feb
        2023 04:56:09 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.1A.61927.86DF2F36; Mon, 20 Feb 2023 13:56:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230220045608epcas2p11d40339e7401f5bf99a9e97308058fec~Fb3FC95xY2440924409epcas2p1I;
        Mon, 20 Feb 2023 04:56:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230220045608epsmtrp1caba9ee99caf62e079a09daf15a53e62~Fb3FCNXLS1499014990epsmtrp1Q;
        Mon, 20 Feb 2023 04:56:08 +0000 (GMT)
X-AuditID: b6c32a45-671ff7000001f1e7-53-63f2fd68e98e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.50.17995.86DF2F36; Mon, 20 Feb 2023 13:56:08 +0900 (KST)
Received: from dell-ArcherCity.dsn.sec.samsung.com (unknown [10.229.83.212])
        by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230220045608epsmtip24520f52e27069e83ea990899a7d43862~Fb3E0TzSM2878428784epsmtip2g;
        Mon, 20 Feb 2023 04:56:08 +0000 (GMT)
From:   Junhyeok Im <junhyeok.im@samsung.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        bwidawsk@kernel.org, alison.schofield@intel.com,
        Junhyeok Im <junhyeok.im@samsung.com>
Subject: [ndctl 2/3] cxl: add inject-poison command to cxl tool
Date:   Mon, 20 Feb 2023 13:57:08 +0900
Message-Id: <20230220045709.94027-3-junhyeok.im@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220045709.94027-1-junhyeok.im@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdljTVDfj76dkg7NfDCzuPr7AZtE8eTGj
        xfSpFxgtFh+dwWxxftYpFotbE44xObB5LN7zkslj06pONo++LasYPT5vkgtgicq2yUhNTEkt
        UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
        VtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIztjU2MJe8Fir
        4smCC2wNjF8Vuxg5OSQETCQ+Xr7D0sXIxSEksINRYuOLXlYI5xOjxNHXa6Ccz4wS95c+ZIVp
        2XTzMzNEYhejxKNbq9khnEYmifZZGxhBqtgEtCX+9k8Hs0UEZCWa1z1gAiliFpjAKLF07kGg
        dg4OYQF7iTn780FqWARUJQ7+WcYEYvMK2EhcO7KYCWKbvMT+g2eZQWxOAVuJXc+XsELUCEqc
        nPmEBcRmBqpp3job7CIJgVvsEssft7JDNLtItPzoY4SwhSVeHd8CFZeSeNnfBmXnS0w9OBHK
        LpFoO3MAyjaWeHfzOSvIncwCmhLrd+mDmBICyhJHbkGt5ZPoOPyXHSLMK9HRJgTRqCqxZcML
        qCHSEkcnbmKBsD0ktjy9D3aMECgU1v82ncCoMAvJM7OQPDMLYe8CRuZVjGKpBcW56anFRgWG
        8AhOzs/dxAhOi1quOxgnv/2gd4iRiYPxEKMEB7OSCK/0oQ/JQrwpiZVVqUX58UWlOanFhxhN
        gUE9kVlKNDkfmJjzSuINTSwNTMzMDM2NTA3MlcR5pW1PJgsJpCeWpGanphakFsH0MXFwSjUw
        6e+JPFmUNkeUZbGW7PoDGq7Hj3qdtLtWpnjzBavgKf91qxd9j30ZJhbTYrp0cb4kS/dOj496
        a5V6+NKu6GX7bT3yevKtsxu7DrL7nFi0SjauvEw4UPGfhun3OPlt0prlDEd+vbf88+eUhG3I
        m4pPoea936Z43E+eN2XqjctXju2Zy/BRbkewVc760vPlCToacqVuP947pTlcXBjCptLxueML
        c2IkY/sOxnc8EvExtzav5X5x5vZEa+fXnIxRoZFcE5rOMN5mvdfYm9TgPqVik5F9sXZNP9PO
        tM+3eBjtGRd7zTPceVhjQ7NNX9PKd2UW91P+pIlr3pn92tNrF2NW7gTTji9XM0U7oo4XZC9X
        YinOSDTUYi4qTgQAhLevLRQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSvG7G30/JBmvvSVjcfXyBzaJ58mJG
        i+lTLzBaLD46g9ni/KxTLBa3JhxjcmDzWLznJZPHplWdbB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVsamxhb3gsVbFkwUX2BoYvyp2MXJySAiYSGy6+Zm5i5GLQ0hgB6PE4ccP2SES0hI3
        HnWxQdjCEvdbjrBCFP1nlLj66idYgk1AW+Jv/3RGEFtEQFaied0DJhCbWWAao8T2vYldjBwc
        wgL2EnP254OEWQRUJQ7+WQZWwitgI3HtyGImiPnyEvsPnmUGsTkFbCV2PV/CCmILAdX8nAVx
        D6+AoMTJmU9YIMbLSzRvnc08gVFgFpLULCSpBYxMqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS
        9ZLzczcxggNYS2sH455VH/QOMTJxMB5ilOBgVhLhlT70IVmINyWxsiq1KD++qDQntfgQozQH
        i5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGphD3ybJyt8M+vptYfDpPV+B11vVFT2/2rlxR
        8LT+5QJrY6OpX7hvHrl5zzz/rtLalt0dd7+u50zM5THJZPjx4nB8nlKqlEGEwp8Vv7Zt7mxU
        cRS8ssUxMCfl9y+vJdVqJ9XudT5dYduUte1cfThj7Vu1N5KGK6WVVUT3P//g2elw4Kx5+vSC
        OuuYywZtlfO+3ahNv9L1ktvxwG2xGGNeu9j1CytUvqVtvv+wccEv64nO/Bv2zIjcXShyIr+i
        o/iL/MRla6JXXjmb+/cSS0RKgcC8yFdeLDayi7mDVzu32G1qm6Z5zLOpWKtK7kf3lwO+Le83
        ar9d/4z553nHRZzTuZdo+7kpP2Ln3sHGaRRsocRSnJFoqMVcVJwIAAH+QznPAgAA
X-CMS-MailID: 20230220045608epcas2p11d40339e7401f5bf99a9e97308058fec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220045608epcas2p11d40339e7401f5bf99a9e97308058fec
References: <20230220045709.94027-1-junhyeok.im@samsung.com>
        <CGME20230220045608epcas2p11d40339e7401f5bf99a9e97308058fec@epcas2p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add new command to cli tool, to inject poison into dpa(-a) on the
memory device.

DPA written in sysfs attribute(inject_poison) is converted by
kstrtou64 with 0 base by 'inject_poison_store' of CXL driver, so if
it begins with 0x the number will be parsed as a hexadecimal
(case insensitive), if it otherwise begins with 0, it will be parsed
as an octal number. Otherwise it will be parsed as a decimal.

Since the validity verification of the dpa would be done in
'cxl_validate_poison_dpa' of CXL driver, no additional logic
is added.

Also since it is expected no use case of injecting poison into the
same address for multiple devices, this command targets only one
memdev, like write-labels command.

 usage: cxl inject-poison <memdev> -a <dpa> [<options>]

    -v, --verbose         turn on debug
    -S, --serial          use serial numbers to id memdevs
    -a, --address <dpa>   DPA to inject poison

Link to corresponding kernel patch:
  https://patchwork.kernel.org/project/cxl/patch/97a0b128d0d0df56cea1a1a4ead65a40b9cf008e.1674101475.git.alison.schofield@intel.com/

Signed-off-by: Junhyeok Im <junhyeok.im@samsung.com>
---
 cxl/builtin.h |  1 +
 cxl/cxl.c     |  1 +
 cxl/memdev.c  | 53 ++++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/cxl/builtin.h b/cxl/builtin.h
index 34c5cfb..ddc4da9 100644
--- a/cxl/builtin.h
+++ b/cxl/builtin.h
@@ -23,4 +23,5 @@ int cmd_enable_region(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_disable_region(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_destroy_region(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_monitor(int argc, const char **argv, struct cxl_ctx *ctx);
+int cmd_inject_poison(int argc, const char **argv, struct cxl_ctx *ctx);
 #endif /* _CXL_BUILTIN_H_ */
diff --git a/cxl/cxl.c b/cxl/cxl.c
index 3be7026..aa8d090 100644
--- a/cxl/cxl.c
+++ b/cxl/cxl.c
@@ -77,6 +77,7 @@ static struct cmd_struct commands[] = {
 	{ "disable-region", .c_fn = cmd_disable_region },
 	{ "destroy-region", .c_fn = cmd_destroy_region },
 	{ "monitor", .c_fn = cmd_monitor },
+	{ "inject-poison", .c_fn = cmd_inject_poison },
 };
 
 int main(int argc, const char **argv)
diff --git a/cxl/memdev.c b/cxl/memdev.c
index 0b3ad02..7a10f79 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -34,6 +34,7 @@ static struct parameters {
 	const char *type;
 	const char *size;
 	const char *decoder_filter;
+	const char *poison_address;
 } param;
 
 static struct log_ctx ml;
@@ -85,6 +86,10 @@ OPT_STRING('t', "type", &param.type, "type",                   \
 OPT_BOOLEAN('f', "force", &param.force,                        \
 	    "Attempt 'expected to fail' operations")
 
+#define INJECT_POISON_OPTIONS()				\
+OPT_STRING('a', "address", &param.poison_address, "dpa",	\
+	   "DPA to inject poison")
+
 static const struct option read_options[] = {
 	BASE_OPTIONS(),
 	LABEL_OPTIONS(),
@@ -135,6 +140,12 @@ static const struct option free_dpa_options[] = {
 	OPT_END(),
 };
 
+static const struct option inject_poison_options[] = {
+	BASE_OPTIONS(),
+	INJECT_POISON_OPTIONS(),
+	OPT_END(),
+};
+
 enum reserve_dpa_mode {
 	DPA_ALLOC,
 	DPA_FREE,
@@ -351,6 +362,24 @@ static int action_free_dpa(struct cxl_memdev *memdev,
 	return __reserve_dpa(memdev, DPA_FREE, actx);
 }
 
+static int action_inject_poison(struct cxl_memdev *memdev,
+				struct action_context *actx)
+{
+	int rc;
+
+	if (!param.poison_address) {
+		log_err(&ml, "%s: set dpa to inject poison.\n",
+			cxl_memdev_get_devname(memdev));
+		return -EINVAL;
+	}
+	rc = cxl_memdev_inject_poison(memdev, param.poison_address);
+	if (rc < 0) {
+		log_err(&ml, "%s: inject poison failed: %s\n",
+			cxl_memdev_get_devname(memdev), strerror(-rc));
+	}
+	return rc;
+}
+
 static int action_disable(struct cxl_memdev *memdev, struct action_context *actx)
 {
 	if (!cxl_memdev_is_enabled(memdev))
@@ -755,7 +784,8 @@ static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
 				continue;
 			found = true;
 
-			if (action == action_write) {
+			if ((action == action_write) ||
+			    (action == action_inject_poison)) {
 				single = memdev;
 				rc = 0;
 			} else
@@ -771,9 +801,15 @@ static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
 	}
 	rc = err;
 
-	if (action == action_write) {
+	if ((action == action_write) || (action == action_inject_poison)) {
 		if (count > 1) {
-			error("write-labels only supports writing a single memdev\n");
+			if (action == action_write) {
+				error("write-labels only supports writing "
+				      "a single memdev\n");
+			} else {
+				error("inject-poison only supports injection "
+				      "of poison into a single memdev\n");
+			}
 			usage_with_options(u, options);
 			return -EINVAL;
 		} else if (single) {
@@ -893,3 +929,14 @@ int cmd_free_dpa(int argc, const char **argv, struct cxl_ctx *ctx)
 
 	return count >= 0 ? 0 : EXIT_FAILURE;
 }
+
+int cmd_inject_poison(int argc, const char **argv, struct cxl_ctx *ctx)
+{
+	int count = memdev_action(
+		argc, argv, ctx, action_inject_poison, inject_poison_options,
+		"cxl inject-poison <memdev> -a <dpa> [<options>]");
+	log_info(&ml, "inject-poison %d mem%s\n", count >= 0 ? count : 0,
+		 count > 1 ? "s" : "");
+
+	return count >= 0 ? 0 : EXIT_FAILURE;
+}
-- 
2.34.1

