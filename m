Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3476DC05027
	for <linux-cxl@archiver.kernel.org>; Mon, 20 Feb 2023 01:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBTBgU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 19 Feb 2023 20:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjBTBgT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 19 Feb 2023 20:36:19 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2B0D509
        for <linux-cxl@vger.kernel.org>; Sun, 19 Feb 2023 17:36:17 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230220013616epoutp01c8742f3d2db1fe2bc1602f8718f4d2f5~FZIkToHrb0996009960epoutp01C
        for <linux-cxl@vger.kernel.org>; Mon, 20 Feb 2023 01:36:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230220013616epoutp01c8742f3d2db1fe2bc1602f8718f4d2f5~FZIkToHrb0996009960epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676856976;
        bh=jOE0S1lpP/uoxhtSgbae+fH/Au3BGni5ipxoEv6UUoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i+b3/LMqy8jK2YQ0f2byEEQhNuVCSMbu49FZ1h9KAzgP/yxdmC8m78wz8CoUqQuY0
         IsOZCT+dtZEgpCxoR+6MDqWPd4hQk2Za2qGqQ2WcBVFLpbbLGdg3vl2a+hngL/qBIS
         uH5ZIjKxDhWi5I86KUkpx4KTPL5hvaZnMAjUNSzY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230220013615epcas2p489b0a7c343cdbab44cc942c55c72a061~FZIjtjITn2089420894epcas2p4F;
        Mon, 20 Feb 2023 01:36:15 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.89]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PKlPV6X0Wz4x9Q9; Mon, 20 Feb
        2023 01:36:14 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.9D.05668.E8EC2F36; Mon, 20 Feb 2023 10:36:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230220013613epcas2p23cee8c0fe839f12ca125e97c6f66d815~FZIiJTQgg3031730317epcas2p2P;
        Mon, 20 Feb 2023 01:36:13 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230220013613epsmtrp2ba5cbe3465123b8fb84f55771782a17b~FZIiIduV40856508565epsmtrp2U;
        Mon, 20 Feb 2023 01:36:13 +0000 (GMT)
X-AuditID: b6c32a48-45bfc70000021624-1e-63f2ce8e6eed
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.5C.17995.D8EC2F36; Mon, 20 Feb 2023 10:36:13 +0900 (KST)
Received: from dell-ArcherCity.dsn.sec.samsung.com (unknown [10.229.83.212])
        by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230220013613epsmtip19972cd83f8867d9ca1f798048653586e~FZIh8auug2382023820epsmtip1F;
        Mon, 20 Feb 2023 01:36:13 +0000 (GMT)
From:   junhyeok.im@samsung.com
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        bwidawsk@kernel.org, alison.schofield@intel.com,
        Junhyeok Im <junhyeok.im@samsung.com>
Subject: [ndctl 2/3] cxl: add inject-poison command to cxl tool
Date:   Mon, 20 Feb 2023 10:37:13 +0900
Message-Id: <20230220013714.22277-2-junhyeok.im@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220013714.22277-1-junhyeok.im@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmuW7fuU/JBs/+cVjcfXyBzaJ58mJG
        i+lTLzBaLD46g9ni/KxTLBa3JhxjcmDzWLznJZPHplWdbB59W1YxenzeJBfAEpVtk5GamJJa
        pJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0XEmhLDGnFCgUkFhc
        rKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQnXH5ySn2gkna
        FSu/pzYwzlXqYuTkkBAwkXiydjpbFyMXh5DADkaJ2wc6GSGcT4wSD44eYoFwPjNKrJ89kRWm
        Zee+I1BVuxglen4tZQJJCAk0Mkn8mJUCYrMJyEpcPXyDHcQWAbKb1z1gAmlgFpjAKLF07kHm
        LkYODmEBe4k5+/NBalgEVCVObXjNCGLzCthI7P7ezwKxTF5i/8GzYOWcArYSW4+xQpQISpyc
        +QSshBmopHnrbGaQ8RIC19glDp94CFYvIeAi8fE5H8QYYYlXx7ewQ9hSEp/f7WWDsPMlph6c
        CBUvkWg7cwDKNpZ4d/M5K8gYZgFNifW79CEmKkscuQW1lU+i4/Bfdogwr0RHmxBEo6rElg0v
        oIZISxyduAnqDw+JVS/PMUPCCRgGr+5HTWBUmIXkl1lIfpmFsHcBI/MqRrHUguLc9NRiowIT
        eOQm5+duYgSnQy2PHYyz337QO8TIxMF4iFGCg1lJhFf60IdkId6UxMqq1KL8+KLSnNTiQ4ym
        wICeyCwlmpwPTMh5JfGGJpYGJmZmhuZGpgbmSuK80rYnk4UE0hNLUrNTUwtSi2D6mDg4pRqY
        eq3sfjnXpbb/zYw7LFTkp99QuY/5wJvDAqt+1lU3i5jcOJ467cj+4lt7G3zfGHz+t1Dn8cwH
        V41+G57L+v14Y+m/MpOT0QG2x7+tnH5g950oBweRU0+NLrNwrFWNSE98oVt1YUac26GF11Rn
        Hy//kbHg8D1WwavvZm+fqZazyar05hqLc591tPwCmstk9tY8C0htL3+o8dp3S1SWz4kOh9s3
        7cLNJBwinha2P7fRKn5TnqPkwqG0ToTJ4OPtA6b8e8sztRXO/o2v32L0+Owm6wfX1oh47ue9
        4Pn3lfzcdstlM1QSRVr4RGfMfx/BFydSq9snr6BzILNHktstQl/iV/aCSXYLLrF8XslypMxU
        iaU4I9FQi7moOBEAYEhI4BAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSnG7vuU/JBo+69C3uPr7AZtE8eTGj
        xfSpFxgtFh+dwWxxftYpFotbE44xObB5LN7zkslj06pONo++LasYPT5vkgtgieKySUnNySxL
        LdK3S+DKuPzkFHvBJO2Kld9TGxjnKnUxcnJICJhI7Nx3hBHEFhLYwSjxtI0fIi4tceNRFxuE
        LSxxv+UIaxcjF1DNf0aJDdc2gDWwCchKXD18gx3EFgGym9c9YAKxmQWmMUps35vYxcjBISxg
        LzFnfz5ImEVAVeLUhtdgrbwCNhK7v/ezQMyXl9h/8CwzSDmngK3E1mOsEOfYSLQ8nscKUS4o
        cXLmExaI6fISzVtnM09gFJiFJDULSWoBI9MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95Pzc
        TYzg0NXS2sG4Z9UHvUOMTByMhxglOJiVRHilD31IFuJNSaysSi3Kjy8qzUktPsQozcGiJM57
        oetkvJBAemJJanZqakFqEUyWiYNTqoHJfvm00vMs4qvMF5/Y0VDG/OqyVHexQYu/9M7eTdrb
        Xtg6TZ21a2PlBP2OP1tcAnoF7OyLn0YqTfzUYBS1p3PPqSm/tBprNK++XvK0TpPn3hLeLe4r
        prZ/lLxbslCdJ0rn46Et65bzyZS9MuSo0fvDNHfeuidztx1b0ibX/jCCP/Lq5aaUpOjpQkFP
        Dy1qM9S2nn7IvjNpU49x43pVQdvSuGyhZVrLvb6wd4ts+BTRc1urKyfqyteCxZ19e39P3b3m
        pMHTxbrtz7z60m7qLtqq98o4Z5/I/KM/kyZN/FctxpFx5F7pN1tObbG644omRbdud26Yr3WL
        +afeFk0XeXnZ/EZ+1zqTJ+lrF/yqr6pRYinOSDTUYi4qTgQAcyNbqcwCAAA=
X-CMS-MailID: 20230220013613epcas2p23cee8c0fe839f12ca125e97c6f66d815
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220013613epcas2p23cee8c0fe839f12ca125e97c6f66d815
References: <20230220013714.22277-1-junhyeok.im@samsung.com>
        <CGME20230220013613epcas2p23cee8c0fe839f12ca125e97c6f66d815@epcas2p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Junhyeok Im <junhyeok.im@samsung.com>

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

