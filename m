Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5FE3BED46;
	Wed, 24 Jun 2026 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782312121; cv=fail; b=emFU9gGTQlifYtjSniFnnxZeK29P4tlADIO5p4SmYD72SoURYYxYdLP3Vc8kxZzLGFeAUK7/Ii90ngrDt8Imkv5HGNARfalStnZDPNCUTW7UQGnqW+GdgPnCGyt37zY6c+ypQ/f41YIZWrHfMBqhp/GOlUrcVI3qBTeG7xd/dJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782312121; c=relaxed/simple;
	bh=tTiRlD9rooj4wR2Nt2OVFF1vsJMa/caBUCM0TpSeXqo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iMwBbSPZ2RcgoubA0NyO05pCynKPPUeAIRldnDIht7ZUezk7Ed+Yu5PmcmiwQXLX+JMdwBaUuZm5kVtuqxxzh02K67mBg7JroPQ/ZPR6ub1nUlwzgHebpr54xouH0A1a2bTPAnCurXapOQl+dxIl5I329CgL0ThgKU8WKn1SwNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jiyqrFHq; arc=fail smtp.client-ip=52.101.61.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jiyqrFHq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2md1MIMqYGCpeeMPWGndvQCiqyVlUMWfgUSUQeLa+ksF/tAWnnTWpd5Ql50455jXGx2MJk3ozCx6rzkdkjhAw3EbtEIntTzygMuHv5SgELztf2McU1U4fPBtpNO2M9h/SdjulW/++Yi/1HyRsDCBSq2nTqt/lOkJxsB4UAIZu3KRzcO2wSSyMXXlZpg5vUbDaMDTyPF3w2nGD/BpGA8KHiH6gcKmK255ErBFdek9IHRdYC9h8VsgMmAMGJ/gwyQ70KEtJfjgxVNnsiH2dli/EwodgLXq5qgvzWNpAQfXD0GgSY5F5v8dQJasA9c+lI3IOY9arwLzJJJfodPqxDDMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1reGM7VUXBIPwrhGAyq9iRi6jNvyn0L928D6xqW8ZU=;
 b=d+GuNehFUjc2Ra00c1X6YuT0HfnkOMijnsY4OeClEUxD47yoiqAM7Nne3W7xgb+f5A587wJYO3TgQjVEtABaACCxK91N8xiO6mf4yEkxRTWQxd6UXfzYhuH7NCK73RkYGYB23qqcIvHrL0rRE+ieNSJ45HQoK6dkzyNU0L6JiuG6LyJzSDBRoDNeaFFr4n6sC9fgc8WGJLTC2ED0i5WHrOi0angc2/b8ZPA/R8mPwIfrXbv8pDkmSOPm38Tf5iCFCOBG2fhADd+/oeLFCb8blL1to8leloBBMwlZYetoHbe9yFjyQhDiVQHfZROaPTpi6UI/YHg4+fTO8bY4DHTbzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1reGM7VUXBIPwrhGAyq9iRi6jNvyn0L928D6xqW8ZU=;
 b=jiyqrFHqZrfxXE3b8RYPSY8c4Ln68UvM363bg5u1h9Zm2nIYrFPokPFuvZxnWyNANt+rtFdrRSmznoCHGYUEaTmaPYll0O8u9YsUls8TNInJVMD8XdHOSn9hfm8wm3FrE+iGETIkRTWM/c9xPY+Ugd/Q1QMq2H/Otd62M9CbaMmr+VdLiiZ9MZvj1mqQF0U2/w/sF0QKqbr4oLcF/zD35olrtim9BAJathhqr88xsAhut6vE9rDTF+P2OumOsZKv8gySoZVLLnIbDav+7aU/LZGrIKQkK7wS+AQOgyTFn8JR8zS5tUlVUDC3RM48dMARXc+YFGow3ImrYz1QjalDpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32)
 by IA1PR12MB8080.namprd12.prod.outlook.com (2603:10b6:208:3fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 14:41:56 +0000
Received: from MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5]) by MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5%6]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 14:41:55 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	danwilliams@nvidia.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	kobak@nvidia.com,
	kaihengf@nvidia.com,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v2] cxl/mbox: Clamp mailbox output allocation to the payload size
Date: Wed, 24 Jun 2026 22:41:47 +0800
Message-ID: <20260624144147.53997-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0042.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::20) To MW2PR12MB2380.namprd12.prod.outlook.com
 (2603:10b6:907:4::32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_|IA1PR12MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e0bf439-a2e3-4c38-abc4-08ded1febbdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|23010399003|1800799024|376014|18002099003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	zw6M7pfRGXIzDZQnU+heyjrWYl7xdLImTGi4iaPXm5yhORYBdi9geg5RIiIhHcEbYw8USZiGeKrNvpNjP/uIjizkI+2BnjKo27TnueZFSmyTciT9XnEdREP3fcCzoxMJljP32MOx1UoLvVLv/CuSRQIiBfweKEGiPYClhlVPy7KOKHF5LNWrdh0gve0gAs67fai4gfJq2rqmQzB93WEmWuO6g/F+WpS3Sw3UQTrJMokpVkOovdmslDcBZ41XB5vagPA7lPdwDX4RHtaDim1i56bYPyANPszH/z0Bm9sJK0pIfl0I9V02UKM4SgU1eNxzcPvkc30OY69NEeo+zx5xiiAUAK80RLSII1ZKpfpcE1fAxpT7qyL4gK/AAoc8NFyM1OtdSnFkCcbfFX0rl8totyn7TSsjBFAQUR4flYkybty1JD6QbKLh+vaiwQKckY/0tDLH/Z8E04gwplvMEZRnk4NMmJ5VPq/Hhb9F5fZ4/4497FAe/p5Pu1V8276V8149JghQAsBO+z3Hkad1bAxOOyNTQO25VgTXJ0PaNcDuIzAN2iT/deJEpCMrfo6nBHRn6OdRBx9ZCOG2zAiSHJ3PqZQYMH7o4N101tRYxPW3ZRLMnq0wGFa6u7hh4mGBlxo7jTayIly3TJ19/6P4LXHY/+7fpReqrtFsERApiKJe7s0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(1800799024)(376014)(18002099003)(56012099006)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QjinP9G8JQ24qfag2LyrawivDlynSiAmyjjcXjRwlOmzTkep+EaRXnSJjDri?=
 =?us-ascii?Q?Xsow5WF4maiVYBmWlVRpsAsx3dcJi7iY+PIZAKr0FVoP3SnXEK8a3OLhNnZv?=
 =?us-ascii?Q?CCSeYri14a7oSgOvniizHPjbuUn+6qjUhMSeSaDOCrd9wfraz4Mvyp9zvXSw?=
 =?us-ascii?Q?SEy/HGd/GRE7++IKLTXM+hKsm5OTinYUv0JHgu6iUXTmGvqZWhj6xSsm4nT8?=
 =?us-ascii?Q?kmCoL3t40KbN83pk6sB4mewQF0/pqW6sPTf7lCRrcBaRyuaOfvhJ6wy51gd/?=
 =?us-ascii?Q?UhDfcXmdvYLTQHblvVVssN0Em9BjrrrAbZ4S72uymtWvVMagALlOYJuJFj3H?=
 =?us-ascii?Q?9pNsYmrT1KxcjY8s33YJHaSQLMSwmK5VA4Q21yoYk9YgjHsXhRcWenhxZjKo?=
 =?us-ascii?Q?iyfqkAq8m/7oIIPo/0jkXsDGfudpXCnP4BQEdymPB1BMYspq9jUyQib/+dTb?=
 =?us-ascii?Q?WSCUec1HOEZzEmH6dt8pPGbjvECTitc/Zm4vPOhsTZWoEgmD8EwZ1GxArFqo?=
 =?us-ascii?Q?TsmjCOvwzqfJEyEk+1kb/aLCCD+0Im1rpHgEHQiNSHjciszH9OcIa2UlUTkr?=
 =?us-ascii?Q?CtwQmaw41qL6Wa820QGnJYxvL0TsY8LpVY38l+wJgQUFJ8aum4R9WbYMASFB?=
 =?us-ascii?Q?NjKbBoLY4d5E2I2mWeQEDZOsh63zcYmwt3fecYZJEtni1gac0IxQ65h2T0Av?=
 =?us-ascii?Q?BqnX52dKUZC1M0YrxvO+yOxKxSaZNEFve02hVAJYpd5aIlwMHCdZYsrwPOxa?=
 =?us-ascii?Q?imvBU+gqzv8aUpjPizBa7Q2Y7oCsTlXqyisnDZV+0iWQeE1U3xoMXhoVXoJv?=
 =?us-ascii?Q?HT/Sd/wm9SREKwYbIND0GIF1JOePtGgq4WTmq4rNQwfadeh5zzrPRjmow3iP?=
 =?us-ascii?Q?oeRiQHAnX1iq1V6uwe1WjZuPHgMsuvp9fk1TJGd6F7USrmbUKrT3ou/ZSTYS?=
 =?us-ascii?Q?/y0JL8J8NMb6fnnbgc/N18ZGtgcZcMx15WRwA/fNPwW/6+V+y8vRWvfja9X2?=
 =?us-ascii?Q?ZuZQ93p5zti2tnLnW0BRpkMm64l3vAN9Tf/FCcE9iOGHqIeboA2Oc2q/LbdF?=
 =?us-ascii?Q?oFVY1Jc1HOGuHl8noq2WpzcH6P6Q68vO3Tgn3y6+cDltrw+efduZGc5kFs4m?=
 =?us-ascii?Q?wi+FtoVgWCVrwUrineAbmEpxhFm4cZTPYFg3YNtLcUhUYTr/eK28JjeM5ifR?=
 =?us-ascii?Q?OvS56g4MC0imlZa5SUIEjqq53xe/e9LPZPNXzBP4es/9ZJm0XXvgbVEolLOM?=
 =?us-ascii?Q?kGtzS7eDSWWOUaZQ/MLcRkdG26unr+6ZwGEvF748SwnATmwqZOejJpXnrqHI?=
 =?us-ascii?Q?lVV3bLpG+pTTKwE/LUtH8OVIgK4nKH7zE0okNHn8sGttClMDCFQ4WYCtX9zh?=
 =?us-ascii?Q?coeQKmNzD3hRs1U7Q36LTdYT7qpllTlKPiGJ4EAu2U6v5Z5Rr6G/B9YUVQ12?=
 =?us-ascii?Q?Ffo94JuRn5aB87TFSepWgnHlZoq7SBL+m3IVzA7DgBZKsc+XhVVUPdczuX5X?=
 =?us-ascii?Q?g5y7xOXYVhacqnGfi8L1xaUYDhx27y34OovtvCW/bxBqwBBXXOQHPNnQQ9zd?=
 =?us-ascii?Q?ePwx0qtpTBU6bd+qLY1jUGsG0Vefc0A1kJVBcsMSYukY+qKCtzgbkEX/PDt6?=
 =?us-ascii?Q?IJ72S39BuIvOviwuYcmANCQxO/e7vcyVW+ZooO2PecM80xXxltqZeCny+g8W?=
 =?us-ascii?Q?vWCqa6HP/XyQsMEtZg5eVGK8W9WyyWfG0/nRHHHx0XKADOoCCh2QKJdqE6OT?=
 =?us-ascii?Q?yAvwuOhnqA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0bf439-a2e3-4c38-abc4-08ded1febbdb
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 14:41:55.0450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l314xsAJJNIAXRVnFgL9Iiy67EmOy4t1PiFS8FYTy3QMwzjvlTVx0ZuEA0ChvROadyy9Y78o7RBZ4X7xacwwKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8080

CXL_MEM_SEND_COMMAND bounds the user's in.size to the mailbox payload
size but leaves out.size unbounded, then cxl_mbox_cmd_ctor() calls
kvzalloc(out.size). A large out.size drives a huge allocation, above
INT_MAX it WARNs and taints, and with panic_on_warn=1 it panics.

The transport __cxl_pci_mbox_send_cmd() already clamps the response copy
to min(out.size, payload_size, device len), so the output buffer is
never written beyond payload_size. Clamp the allocation to payload_size
too, matching the RAW path.

Fixes: 583fa5e71cae ("cxl/mem: Add basic IOCTL interface")
Reviewed-by: Kai-Heng Feng <kaihengf@nvidia.com>
Reviewed-by: Koba Ko <kobak@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1 -> v2:
    - Correct the Fixes tag to 583fa5e71cae ("cxl/mem: Add basic IOCTL
      interface")
    - Drop the reproducer and sent it as a regression test in ndctl

Best regards,
Richard Cheng.
---
 drivers/cxl/core/mbox.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 7c6c5b7450a5..d9cb02c9f72c 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -380,11 +380,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox_cmd,
 		}
 	}
 
-	/* Prepare to handle a full payload for variable sized output */
-	if (out_size == CXL_VARIABLE_PAYLOAD)
-		mbox_cmd->size_out = cxl_mbox->payload_size;
-	else
-		mbox_cmd->size_out = out_size;
+	mbox_cmd->size_out = min_t(size_t, out_size, cxl_mbox->payload_size);
 
 	if (mbox_cmd->size_out) {
 		mbox_cmd->payload_out = kvzalloc(mbox_cmd->size_out, GFP_KERNEL);

base-commit: ef0c9f75a19532d7675384708fc8621e10850104
-- 
2.43.0

