Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607943290B9;
	Wed,  5 Aug 2026 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913193; cv=fail; b=C+RutLeUsbwWWjFiBkfcO90pyPR6L085zJPbUEguCulhCm1UOkC6sn/5CuxKErxMIbOPeDf3uEeGb0VgJqm9KaMkquzpbO74aGp/KWTDfoDkOibWkuqmrPHFLMkkYKwt5bZwowDx6eJA++tGPmsSsYL6AJrqRCRk7One+J4Es+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913193; c=relaxed/simple;
	bh=MCbI5vdo3v4kWb7ju/iyFLgOqKRm7Eh+gMVndOmljnc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BXqp7g9qnxnnK5izGAB7Yp5ArPX3i8JoxHEKK0Kq+04cZhO+3AtvpzAQ2Rlkjwb1d7BgDPg/29CaohBdPcPv4+PBJfwTuVSaS9BzQNmRa1eoX3SHe+RCO5jGy+AhWKQPv5twdLZjUmwsLJ31EOBFz9YRHgpm/WWVV1JBiLCwC5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f5Y5SYWR; arc=fail smtp.client-ip=52.101.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f5Y5SYWR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teaZI+wMPMVmg4ZQs0pdMs0FHvUaG+vk/fOor372/X//HOzr3YVqdc4Z+zZDTWvJ/Stn88o5lOs16GpGKRGXMDqdTCPvR/GgKh/dQIA2TRyfkSMQ6hMBHh8w0Mx7YYrBTlUPsvsHP6EaSTkKGatVch8s+DDASOx8feSv0uEm2bONeevzeg0IY8xIkvbPTF6LBVHhvz6/pjdq/5Fdkw5lqOfE3GoHvfAX0LgVd0rZl8ML4FfaPQ4vURB7PBzTZtwnFpdfAVQD0BEsfoAS8edgwbolbsU2iFIIABP3ylQOwGvGxW7swzEBamo28y9r9FmL/HU0V0ptYi9OUL0++IpKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RypeFQqX/IyrqJrB0qR6e62loPoOt7Xlce6LiKhXnO8=;
 b=X5N3Fiho+z7s3UIpUDqtNrkLU+M9bIiDQ9LDBcFXJOtZWNh+QH9faAHqKbWWZQmBpB3WzbrU8VVx/B/Bnx5qnfdrEcDgzfbdDfHd8FqKaxRg36OGoa1iHXxeqgdN1WjFnpYfoFEcqj4DJAAIDmF/8MCRLQ7ESAjrKf4eI7vpyTfCQf+RBOPm4uSHoEWW1JwiQ/ATBOiXUyw6YLgrTFBFLrb2bliycYOiOxcxMLVByshFFUtsdprMcsNNXVf0+CkR1lUw8846J/xkppSAVMzARIRfOXy3Lb9BXLhURKOAJeGhRzokwWyDCiGMrEU8DvGyObcP/1uuMoBeoUqw7d8r2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RypeFQqX/IyrqJrB0qR6e62loPoOt7Xlce6LiKhXnO8=;
 b=f5Y5SYWRyNUGuK9gFWgqL1RgP8z19FVoDCSn/XylR9btjntx3jgGDN/kb/sbFyxQ/+EmMXfJrg0weE+Z9w6gyZXpfO3q9frFmbpFnc41UUzis4QCX6ediAp6rW3jMQHVuaYcPca92v5QpHEhdS2lJQZ3xL5tYQhkdQ5juNfp1kV8mMJMqp7bhl9ISUh9Kw0n+yIwAJ4KXVtRoOfBFzIxxALLw73lVHvvVQt2GLyXX9/xCCPHcgG56O+xxve/9j0lwGyQYJLGCg9cBy5bIHvYc3KFxFmh0e1icR8MJziaSIa6tvbxZ5ViHNAgotNTB6JA0FjR2Ge0S6693R3ZJUrImw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32)
 by SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 06:59:47 +0000
Received: from MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5]) by MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 06:59:44 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v2] cxl/region: Add cxl_decoder_is_passthrough() helper
Date: Wed,  5 Aug 2026 14:59:34 +0800
Message-ID: <20260805065935.27837-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0050.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::12) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_|SA1PR12MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee45542-bd8c-454e-39b5-08def2bf1fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JeVoKTUwRQ2UA7O0XUK66Vt4jOAuG3vlXHl4+PZm2l2eX1uoUqF6K7pQuWXXZV+h38yLbzrceSS5Dr6SP9RXI6ak/I22X94aNSrponFl5rD8kie0BAMmeRYDbBkXDT92neN5D98sKc8T3EwyFg7wM2Ceusbl5aRNiRnkWjor3hNQiIFlsDRZCgA+5sHTW+2W/WsEMCxTInGogha0GyLWvsc1DelGsoIri4tay57BUYvh3IoJBqzbHSvLAh2kaZREJuYv0vwgbm41ysc7Ninx9I6ZgcokslDOA63yZTUD8bMNcGr1kPeaWTu+ArGWeQ5OTL0flvhJoVlvvAgNKlovbN5a/ESswkmp0lu54M96skGTijAg0dmM9DfyMzMMI3AB7kmeNUAmJ0BDjtp/caNjQxYPFJDrKWH7xEnmD/e9ZGolkHQKr7aPjOBxMghhBzBKIEZP2w2xww0VOkXkRilgG6F75a5s9w0tTHb8EH6jmdbcVzjK8pvhVR+PdxRyYUOreosHiHlpx9eNFOnIMXSk2bCzXs8n0OkxQoYeIBb9wMuiCNijWyz+R15PCVHQ1tPyQI7lA/Lzm2+8aFNkQWTBpd1M1DAqPpLUl39qUghAXKdPLNh//9fPlNIWy2v+XwmBv9p27MexxTSF7QjXFbv0azBo1uWsXozTXmBTRPqhEvo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D38iu4rR1+38Gl2oGHmRc7MEL3u8b1EwBJO8QqPzp4KBXH/MGgpl6q32yyhy?=
 =?us-ascii?Q?eR5l2PuV/9K9KHuk3/c8rQKeooUdGHLHA2WQr7CjxZdfRbDv4EUghvnWn0A9?=
 =?us-ascii?Q?msi1fUkEvskHaEXsDBhI25CbSoc/iSB+NGqCnsHevIcI+9uhYQB2ltLQcTBq?=
 =?us-ascii?Q?/fIJN8gotvyaL4MLvrLskEECtwEArlPXLYhleR7kJ94TMNmgkxzSZfTd5HzR?=
 =?us-ascii?Q?i/UcE4VoUMF6LOISePqQmEsgifS5n35YYB2/+xUEPWsfM1YtjzqyNcXQTjdK?=
 =?us-ascii?Q?jIeL3vWUhF57vtk5/I/NNHUBhPKy9wGxPU+BJamQrIjDHzyy+/Qeq2PTdkUf?=
 =?us-ascii?Q?FvGPVkyZasxoQ3k8R9cUo3plmpmxtIvP3JMYphxdVFY/N2jOdsgYele1PeYG?=
 =?us-ascii?Q?LBlWqg/E8oL8VUoiLe3iDNq0Ui4iajyUYsuOd+MV5HCecpycX2R3/xfD7MRx?=
 =?us-ascii?Q?hlJ2ylO/50pWSDL71ojPfutb+glTSYBCVlCM5uLIayd4MSSvGpr6H/f/d+ve?=
 =?us-ascii?Q?zxcqZg3D9wcN5oLzpW1NwI7ePzClpd/ljw1g8+GPuPhiwohdiw6peaAct64m?=
 =?us-ascii?Q?cLY3ndPA2y/Mlw207hU/4pnBzuGyhv+vi3/p3U3xenAR/BWaHNQBVa5+/CsQ?=
 =?us-ascii?Q?kvsXYAWwnFZZk9rRQr/6X1cgEaa+6trxUacZJQCkFMAQLUZFpKkg5PxdUAfm?=
 =?us-ascii?Q?cGuTARTca3KdgqVRKABz8wSpS2As+VeF1CTM/FGFN6I3FmV8eXr82c/BWtEB?=
 =?us-ascii?Q?v+LCWYd4gWjToVmINQluEgoM3XGUo1H7V6FCjm+te18XHsKlD8hyz9la0Vs0?=
 =?us-ascii?Q?UuUB36H3I7otE7T4RrHBJR5u2EBwThfGCYloII6F6CzBvQ0iDfTJQpWNh9lM?=
 =?us-ascii?Q?q3lcejcFfHDXoajn0W3iT+gGwpYd8gwD9M08EIGPnsv+Z4gP+FdTuTMLXb3Q?=
 =?us-ascii?Q?vMgWlbwrQGFu3U8no72WM+XN0dqQ5GDN/Mj8tRAC8VzfxrVd9mhiThP5zjrC?=
 =?us-ascii?Q?r5SKYrHY6x+XMRvTk1EhkB9aB2u71krlOACqj76ynbl/Kd7h1urfvVfL9uki?=
 =?us-ascii?Q?PzaIfxDsJOQblg6W6wWvDmp0DEjYNawPHPls+Bp/Ho8u6DsHNm7Vi9Zu9S8p?=
 =?us-ascii?Q?JHZaQpkbBpnPn7qgEH9od3+4J7qX8bx0pWa6UGaqAH3XA2z7UkGU2OatVwbq?=
 =?us-ascii?Q?rKuddTLPTwcAEzDgD28/OawbPaDD+/3s7Ck7AyFlz9IIy3CXz/HGVUA9AYUq?=
 =?us-ascii?Q?nRgIgCgCcCvHVQ9zBkTJ4cnv4oxPor0tsjtfCIbzgu2Xshbb+XnHB44NDWzP?=
 =?us-ascii?Q?/RjrUiFSjulxUrb6MsOPeIanwTBdwZjxv7F81ZIXGVpzYipZOlSA6rlz61q6?=
 =?us-ascii?Q?BirXkXx3Zl20vpBAjuFipJI0Y8OuvzaXC2oq0b+w5TwwaQwzKssSRyedrinb?=
 =?us-ascii?Q?rbITjZcsvHMNjvvANv3H931Lh4Q3JxYXjXgDVGD2jxPZT1H9dvgqr0bI8JmD?=
 =?us-ascii?Q?M5LEu7TAlD1+sRB/ZKiXoAcWFLjJkwD1MqzYzTi911e5ibYMsr1YKbCTAeHg?=
 =?us-ascii?Q?wHLCIMlm0F5/wpT4n0EQFaPLp9KqAvH43JqmL3FKPEEWwatVG7OBVckv7ZzI?=
 =?us-ascii?Q?OkJJ0KydkxYUau0ooPRCkQXuUWgWz7Dfgq3Gi9bdYPKuhSCGYiev/XiL+wAY?=
 =?us-ascii?Q?BR8qWKRBEITpU8YXAuC4qfCLVR4ndV6ucL4OFXuclwA0avHZlY+YazQ+3HDs?=
 =?us-ascii?Q?N6jSwjIWpw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee45542-bd8c-454e-39b5-08def2bf1fb9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:59:43.7703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDPtrcnus5iiFMBzu38kRuj4kF4p2aLgv1C/56MwhiRU2zvczPtSYtjzXWtIQLEAr2IxXe6w4VQMSxPfcVt3DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162

commit_decoder() open-codes the passthrough test.
A NULL ->commit() plus a switch decoder with at most one target. The
call site is hard to read, and it suggests a NULL ->commit() alone
identifies a passthrough decoder. It does not.
DVSEC-emulated endpoint decoders also leave ->commit() NULL, and root
decoders never set it. A future caller testing ->commit() alone would
silently include them.

Move the test into cxl_decoder_is_passthrough() and document what each
condition rules out. The helper runs the same tests in the same order,
no functional change.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1 -> v2:
    - Dropped the passthrough F_ENABLE restore patch. The bug was
      already fixed.
    - What remains is only the clarify helper function patch, so the
      patch is retitled accordingly

v1:
https://lore.kernel.org/linux-cxl/20260727103743.63343-1-icheng@nvidia.com/

Best regards,
Richard Cheng.
---
 drivers/cxl/core/region.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 27e63e6dab7c..cd73684fbe97 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -293,17 +293,33 @@ static void cxl_region_decode_reset(struct cxl_region *cxlr, int count)
 	clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
 }
 
-static int commit_decoder(struct cxl_decoder *cxld)
+/*
+ * A single-dport host-bridge need not publish an HDM decoder capability
+ * when passthrough decode can be assumed. The resulting decoder is a
+ * software-only construct with no registers to program, so it carries no
+ * ->commit() operation, see devm_cxl_add_passthrough_decoder().
+ *
+ * A NULL ->commit() alone does not identify one, it is also NULL for
+ * DVSEC-emulated endpoint decoders. Test the decoder type and target
+ * count as well.
+ */
+static bool cxl_decoder_is_passthrough(struct cxl_decoder *cxld)
 {
-	struct cxl_switch_decoder *cxlsd = NULL;
+	if (cxld->commit)
+		return false;
+
+	if (!is_switch_decoder(&cxld->dev))
+		return false;
+
+	return to_cxl_switch_decoder(&cxld->dev)->nr_targets <= 1;
+}
 
+static int commit_decoder(struct cxl_decoder *cxld)
+{
 	if (cxld->commit)
 		return cxld->commit(cxld);
 
-	if (is_switch_decoder(&cxld->dev))
-		cxlsd = to_cxl_switch_decoder(&cxld->dev);
-
-	if (dev_WARN_ONCE(&cxld->dev, !cxlsd || cxlsd->nr_targets > 1,
+	if (dev_WARN_ONCE(&cxld->dev, !cxl_decoder_is_passthrough(cxld),
 			  "->commit() is required\n"))
 		return -ENXIO;
 	return 0;

base-commit: 212e015fc34712c849653cdb3179cd643c915015
-- 
2.43.0

