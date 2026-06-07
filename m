Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3CC36CDEB;
	Sun,  7 Jun 2026 08:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780820047; cv=fail; b=K+OvsjptlWj6trN/RJqh4zRxef/2nsSiHlyWU9SIQm3mDJy0zpie+RHJO95oE/5BGqJWAQ7X95LurpRpO/owwu1YHjbuOGlydHZyTtsajhjWIw4ksMUQ+gjG+zwmrNuCWY+M2z8jytTMfWN64XtK74fdqMTGqC1DDHkoTRsl6v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780820047; c=relaxed/simple;
	bh=Kd95hAz6hZLAClyuDa+QWVNWjo0PeKQ/9GXdwL9pODY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A8l9BKUxY6pS79+/3DkDav8dlP7/obD2ImeUcCCUJzQyhB5o6gxw5UoUo/oIRj3E5OwCiHnkXfmcCSWfJ7CZzZaMIHawHdaXDOyI/4qGFRJuupvvk0BFF6GLvZ0xy8MYq8HACmphVUuARdf00rc77guDn7tItcz6KFjJwqNSRic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DPB2k/Vs; arc=fail smtp.client-ip=52.101.57.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DPB2k/Vs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccO3TPUIFWdLd+CwtpenYZNO/bHX20SklR/IcRZITGP59bcqtAgNFVSp4rFndrg8Tvz79Zn0+PXAo+bM7MZiH81LPC4U7R8XaXlA+GH2Wb9Y/gpmVQY12CIimghTR+5mJAH6ZcvmNQOqLYSuxzu+CQN75k7U3tI0Jfgkvu2PCCdHOfoZtsKKoSlc8lUOAvJk8uRGavJ9jAsYBev8UJvga8/MMFZxZv5XC/k4VD04v67akL4pGaE0va0F5tLChKT5/pYens4KcApWBoLU5EEkSVHLN4eRzRL2f9zgB4vcY4dmMG9DIiYNgEVH2eTBknR1edEG/8Sj0gDVvpJyDv2+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orzIiGW+6zp5hau/N4jFhanffI3rq0zZQe0TG7gT6EY=;
 b=i6TG0nsRMCyPXgciViUnzW+mTvdR8Utvz7HejIwGxL4P/kIBqAwDFddsy9i1ZlGZWgaox03SxbGJHPorp4YdVcnbbsVsxzdzpzLKYbjQNjpPAszbteWC0UN+/8pR7E2g7/CrCTQUssFU+UHoHs8RGWnnwM4kZTKHe8WOiBrMttTwuisNwkDLNw3ddYM02PUZg6tiic0utQaBuYI2wzAZ2xjB6GI5id+bN/Bv/LQo4dfLCqiCp2DrbG/+p9RLtlXdLL1ltjX5SepZDlkmFXCfOAfFgnCi2htbPTNIPoXf2+hNSRtP5+ZU1ghuXfsWx7P7OZr7WK9FXwHlPM5N36qk1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orzIiGW+6zp5hau/N4jFhanffI3rq0zZQe0TG7gT6EY=;
 b=DPB2k/Vs+8m0Vp7W0L/4J/gynGkIqIU1A0CAE9cSXkitr3Fs9ioyJXfKTF3LKA+0Y+N03+r/K0oy4sMl3fSE7vBTsf4h4cglXL7Bapn1LYJfwDEhM+zRkf7ugy+wFlILIDEPlI6pJPoiw2iGCaBM/FVabkNxjB80licPTGZ2zcsq9kTfn7BvVDhNASach1XErcUY+es0iZdYnFTyrPV6Yb+ajAnwXI7Ee+t7oXq0nKVWOgQAHNN2VgAk/6WhcvVm+XWawZOdqzDl20OJxwLtZqeE7iJu9hhaCXqA6/9sfU2FO0EGtZYvmaHhdXmIa7RG6zC+0Mu4dYMEG0tJ/MblPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SN7PR12MB7417.namprd12.prod.outlook.com (2603:10b6:806:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 08:14:02 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.011; Sun, 7 Jun 2026
 08:14:02 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	vaslot@nvidia.com,
	smadhavan@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v4 1/2] cxl/hdm: Allow zero sized HDM decoders
Date: Sun,  7 Jun 2026 16:13:44 +0800
Message-ID: <20260607081345.61954-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260607081345.61954-1-icheng@nvidia.com>
References: <20260607081345.61954-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SN7PR12MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 0038f44b-e448-4f0c-7b7c-08dec46cbbf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|3023799007|18002099003|22082099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	w/S0BjcNyGgO3PvO54+FUu8lhcuBgKTPsBl7nzWY/sWTMQ7YUdFw3HcNv8epfZzXZA6f4PiOKq4hkXxIj7Mn6X5bqiFGMri3Z0SkV93WICRv6YZBi6O0NGOyfrYC6uKDZWzUI5iVtfJnSesOg+2iXsoyUvGuQWuhkSwH6nBt0i+yHG4GO1S6C0gVZ5pmg8N6HVqhNAqZp0JRD/junV293Yf+JBguXsYeDwXYloczjoshdraFTVhI6M5ExqQ5AQVCFZi+lQa/wkZYn0rCNF+ny5bIfuiLxZDBrrLVHtjG+RA5cjq4x0k0VV9gpymuE9qSCkliQLKHx6qtkbS5twj7ZIjEmqCgfwPmVjqBQSeQF7/4GQR+N22bNptU0YjfnMhUj0zWNjN6C7EECayfynCsfrhDWNWGqF2YLRo9B499Q2viNVrT2a71VRPMwjdm0YTz5d6yHAlkacCL+zDbRzq69FWHKjWUYvrbH9b1kTEdCO2Lc/Tkm5zKqqAXI269F9vjPEDwAXaZVqQdwAbXVcHgQzMLhzq1Nb+wGQ1UmJ5YGHW3TGwR29u162KF+cQ30lkpmTHCMFH88RqLRQ7mXQdM1oRHuG68a974dckre6/m1nC8p+a+sgqDZ/RKCFuP/hko6N4Oz/7w6dx37hiF2ZwiFgvp/sbPK9wbujfAfUdFixjETLXD9blmWDFfjQVIK8oy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(3023799007)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bmc0Dn6eDb/6OIQQydVHqo0/D6xPJPH54pBh/Wc+N8rCJDl6tro5TUzNaWQ2?=
 =?us-ascii?Q?UEGWZAgAnAdvebzOlOuCwbV9Fhrf4boqIipcKosJuAoBDAL4W4MhawLFXcr/?=
 =?us-ascii?Q?eiQR7Im4OR/K6HD63eLrLOuCxgGDohvN8BFS13Qf03hicKWJEhwSm7WoRwOC?=
 =?us-ascii?Q?sPdMWZxhANKGCBdmqM7oLQgymOaRjH+lfWQGhyjtgRQEn3rz0qWQy58VLuRA?=
 =?us-ascii?Q?NMonzqV4hrkms+G/DgvTTpK4TnVG7GT/pilXIeoRMCzd2kUPybr7JP7z46sV?=
 =?us-ascii?Q?L9edFjgfMpmJUoR/jO1D7qCK7QzZz9MnBHGP4gPClFCtK8Xp0/X4USD5QbMh?=
 =?us-ascii?Q?pGAgmCEIkF9OyW0bPt1VOB7dZ89pvlpT/2pi2xlmwlSua2uJSSUQYYAfMpBU?=
 =?us-ascii?Q?E2U/ksbrVteDYsW8mnUV/oNDCUxGs+0SIWRX960DqxNPvwpwaWxLST2i0+gj?=
 =?us-ascii?Q?8UeDE8mFKX3OC4rD/hoYp4uXwcEDtCXx5CwL3SBodzRmLxq7bM/9pJhYbwuG?=
 =?us-ascii?Q?lDNGxj5I38koI5euwn3hdubwtz4ONnNIK0CFlwEq8gnSDMc1rhU557Q4cHiS?=
 =?us-ascii?Q?f+5TPpbZykcAvQ3ZhlBz7AByUSlGml+Hgh2DSSrAjFy7rNOpbD/WrcqMjul9?=
 =?us-ascii?Q?zTJCxNxo8P8JthmZPY1bAIk/jmec8WoeHsry9uP3uvPPhWj78TZD1O1+Zm23?=
 =?us-ascii?Q?l6rwNfpbLqpe6JsZ5UQZrJKwce3WgMb9JIIjrhY/2QCtpC1PKX/l1lGUJ01s?=
 =?us-ascii?Q?qGH3usUaXQWE8WCq61qJ5/59/RZd07EYUuyHe8ZtgSKBKsSVoIIYISv1wNHo?=
 =?us-ascii?Q?+WPlRrkgbDoanAnpn+6vrgkrYrDJzTFO9JkxvMbaOUHkMpCXCZ5tkhsdMIaO?=
 =?us-ascii?Q?GgM9q2ZihQfKgYKQzFU5nOWvI6MtvIMCOzUGSpSQv7k8hqk98qV5zCQoWYRs?=
 =?us-ascii?Q?WkGk71ny4Lb7WWJ5bvS/UcT4XUXChU5x5w97kMvGwimoepfdk3ljjAYXeOTn?=
 =?us-ascii?Q?NqQeqAWjvJZ4hB8IOxnOIJe+sPEB19NF/Wj3wlYAYrFjXrDKjuse6RLHZ9+E?=
 =?us-ascii?Q?plRZsDoktydadJ64K8H7jXlrgJBh9gMbHvWzCtXcmHtXXmdqS1OtTCYu67qR?=
 =?us-ascii?Q?/HGZFNJKrVEEE7/RQn0hIv3C2uLlmFepXqQDxv89jwb+iDMy7mPkt4kGUqXA?=
 =?us-ascii?Q?hRO0iF5coAb+RgrjdIxVjrCELpinPNK5AKyY4u3G0NB4xguGnopayn6K+9X9?=
 =?us-ascii?Q?AFWZGmdA3LVXYxzDQNfob7dyJxRHdtJ66nL1AEcg4f0YYxRIuI35aovm5oV6?=
 =?us-ascii?Q?j5w6FHMaZmxQY8fpnNQyUFJTrX+V7fqn6ohaZAyjAG5GnllOriyWgoi75/TT?=
 =?us-ascii?Q?3B4weZ6Z3g4CoeJOG6LjIJzmNzacQ6CwslwV6ZtdI4r8R/jHVWYZZu4Ylg31?=
 =?us-ascii?Q?4Xx/IXcFlvXQXle9Sa6c01UEcWu0+MUqHhp1EyWXa92arNthPjg0vsOZAZB4?=
 =?us-ascii?Q?CJjwEEKpb8mrrrEm6BTBfjosLkUE/AM1nsNw4Zd3fiWo1gMAqK96zgbz50T5?=
 =?us-ascii?Q?XFVnSO6C6ZrdzZlZO4QPgsL/fxe292jEFTrS8OLoOqVX0jjNLGUU9sCiEnt8?=
 =?us-ascii?Q?N6NENSyIOvE6mDPsNLCVsc17EtqRDEu/fcehaingm7bWqoZU1loGivauHFDt?=
 =?us-ascii?Q?MpGf+R2PDYcC/Orb0Og/WpX1GWYBdUz/h2y2uFdXBtOP5wvHVPOvpdgu0Hsk?=
 =?us-ascii?Q?SRBL52WgDA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0038f44b-e448-4f0c-7b7c-08dec46cbbf8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 08:14:02.5653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsaBk4hUOUAmD0sOAAfpD6eVNDWt4AkRuJMX90evKss6moZQv12OsZibs2L4Sl9v+VWhfjheYSOA6aQKu2xhFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7417

CXL r3.2 8.2.4.20.12 and 14.13.10 permit committing an HDM decoder with
size 0. BIOS commits and locks such decoders to burn the trailing, unused
slots so the OS cannot program regions through them, e.g. a Type 3 device
in a TSP-established TCB. init_hdm_decoder() rejected these with -ENXIO and
aborted port enumeration, so "cxl list" showed nothing.

Enumerate the decoder with its hardware LOCK state and skip the DPA
reservation it does not need.

commit_end may now reference a decoder with no DPA resource, so
poison_by_decoder() must still scan the unmapped DPA tail.

Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
v3->v4:
      - Drop the port->hdm_end advance for zero-size decoders (sashiko AI
        review). The write was outside cxl_rwsem.dpa, and advancing the
        watermark without a balanced release strands hdm_end and breaks
        LIFO teardown. It is also unnecessary -- zero-size committed slots
        are trailing and locked, so the in-order check in
        __cxl_dpa_reserve() is never reached past them.

v2->v3:
      - Advance port->hdm_end for the committed zero-size decoder so a
        following committed decoder still passes the in-order check in
        __cxl_dpa_reserve() (it was left un-incremented in v2).
      - Fold the poison fix into this patch: commit_end may now reference a
        zero-size decoder with no DPA resource, so poison_by_decoder() falls
        through to run cxl_get_poison_unmapped() and scan the unmapped DPA
        tail.

v1->v2:
      - Add zero-size committed decoders to the topology instead of
        skipping them. Drop v1's -ENOSPC sentinel and the matching
        "continue" in devm_cxl_enumerate_decoders(); fall through so
        add_hdm_decoder() registers the decoder.
      - Set port->commit_end unconditionally for any committed decoder,
        not only non-zero-size ones, so subsequent decoders satisfy the
        out-of-order check.
      - Add an explicit early-return before devm_cxl_dpa_reserve() in the
        endpoint-decoder path. __cxl_dpa_reserve() rejects zero-size
        decoders.
      - Spell out TSP and TCB and cite spec sections in commit message.
      - Reorder series, implementation first.
---
 drivers/cxl/core/hdm.c    | 23 +++++++++++++++------
 drivers/cxl/core/region.c | 42 +++++++++++++++++++--------------------
 2 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..b61f51134551 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1031,13 +1031,17 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			return -ENXIO;
 		}
 
-		if (size == 0) {
-			dev_warn(&port->dev,
-				 "decoder%d.%d: Committed with zero size\n",
-				 port->id, cxld->id);
-			return -ENXIO;
-		}
 		port->commit_end = cxld->id;
+
+		/*
+		 * CXL r3.2 8.2.4.20.12 permits committing an HDM decoder with
+		 * size 0. Enumerate it into the topology with its HW-reported
+		 * LOCK state instead of aborting the port.
+		 */
+		if (size == 0)
+			dev_dbg(&port->dev,
+				"decoder%d.%d: Committed with zero size\n",
+				port->id, cxld->id);
 	} else {
 		if (cxled) {
 			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
@@ -1096,6 +1100,13 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	if (!committed)
 		return 0;
 
+	/*
+	 * A committed zero-size decoder reserves no DPA. Leave port->hdm_end
+	 * untouched.
+	 */
+	if (size == 0)
+		return 0;
+
 	dpa_size = div_u64_rem(size, cxld->interleave_ways, &remainder);
 	if (remainder) {
 		dev_err(&port->dev,
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e50dc716d4e8..a353d8e7489d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2907,38 +2907,38 @@ static int poison_by_decoder(struct device *dev, void *arg)
 		return rc;
 
 	cxled = to_cxl_endpoint_decoder(dev);
-	if (!cxled->dpa_res)
-		return rc;
 
-	cxlmd = cxled_to_memdev(cxled);
-	cxlds = cxlmd->cxlds;
-	mode = cxlds->part[cxled->part].mode;
+	if (cxled->dpa_res) {
+		cxlmd = cxled_to_memdev(cxled);
+		cxlds = cxlmd->cxlds;
+		mode = cxlds->part[cxled->part].mode;
+
+		if (cxled->skip) {
+			offset = cxled->dpa_res->start - cxled->skip;
+			length = cxled->skip;
+			rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+			if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
+				rc = 0;
+			if (rc)
+				return rc;
+		}
 
-	if (cxled->skip) {
-		offset = cxled->dpa_res->start - cxled->skip;
-		length = cxled->skip;
-		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		offset = cxled->dpa_res->start;
+		length = cxled->dpa_res->end - offset + 1;
+		rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
 		if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
 			rc = 0;
 		if (rc)
 			return rc;
-	}
 
-	offset = cxled->dpa_res->start;
-	length = cxled->dpa_res->end - offset + 1;
-	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
-	if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
-		rc = 0;
-	if (rc)
-		return rc;
-
-	/* Iterate until commit_end is reached */
-	if (cxled->cxld.id == ctx->port->commit_end) {
 		ctx->offset = cxled->dpa_res->end + 1;
 		ctx->part = cxled->part;
-		return 1;
 	}
 
+	/* Iterate until commit_end is reached */
+	if (cxled->cxld.id == ctx->port->commit_end)
+		return 1;
+
 	return 0;
 }
 
-- 
2.43.0

