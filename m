Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013043.outbound.protection.outlook.com [40.93.196.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B42839DBEF;
	Tue, 30 Jun 2026 07:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805651; cv=fail; b=XaHi2cdsAZ4hzMZWf51r/caHNNPJsb66hWFsyk6Yxm52iF92nfAgYzA2QdtP5E9QlSkEVtI8E+fLb5KRWm4N0hHE8buRWE26fD7po/KY3LKdbCO8YxQyqGA9CfaoO/Jf9iFlfVXhNdpCWpFjXtEvfuy0m/wIKjGiVPWYmdiZoEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805651; c=relaxed/simple;
	bh=W1qrmP4zuNGuaH+fyHDXxevuPOxB0BkJyZVefn+lOmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a9jzIFFEkxZ9symRzfZet+0Jm8bzvS6zWUdXpoYIho+KwnRH4TPtibwAskIFfT6vFPEnmfFNIHwxzaV4K355VlLGlPYMkuWKjjEZxqzwRb1yW3nnXDgjeYVNZt//LCFNN+sLhtlebbyqsmc9MRysKJw2dI6HJaKNjy0A3/J6D2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Awqc/Koh; arc=fail smtp.client-ip=40.93.196.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Awqc/Koh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJ2F+htnHMRxvNpX2s7x48y0SSAwBIQpLeM9jxYgf6ql5R4w/0BBZ9ZpSTpCqZA+hi0NLO7JlII5THlRAODn272LDHZ3Z8Lp+vZ3zh82EsE0zu8kzP+JGHG0jkjB0Dvp0CGaQkZTk5btzR6bPMbKeaHq+WC3BkYCOE0QGe/n7VflY7eoUsvG44BRNFzn8LPMly5iM0NAYPR0fCpvVzTZtS8zS7nYsxam+up3s2S6YXdWiD38iwrkPKC66dIMhYefJUTvdDSLpMZW9ITkP5vpa+ITV99HMFLp3fVsgXZLFMGHsKku2OqZPRjXSfleXRGZqgNlXLBOiXf6kY5GhiDRrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBZQS1S9HQ1zgZsrvrMFQktl+YPUVF1Ht8qiAXkfs44=;
 b=hDYlJEVcGEl7BhMakQ47TwM6r/bXaDCFWAkJApkt2+ls93li/pChP3qLYgnVpOE2QgU8ww8rRR+epZdkAHnxgXbjtHtQcZIxaPbItOeWe9xiZiNHUlYqn7q+2fnFtweuH4tmXsnD3L8h24njXADKZYfEJ5a75T8/E3bIzxVcF2wAlT54ga41fMFq6qJY4dydn7yeoG5L197Em38SaN9VCEpkv4YNYMyZMfEueN15LlQUySf6QF0mK/2WKcJnxMvXshcRL2svqq/14wZLU5zBgltVsWeaYwlAdytPhD1xooTqs3ZRnrjESJ5snx4+RVU5oUX+UbyZYcX/thUlVMjstw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBZQS1S9HQ1zgZsrvrMFQktl+YPUVF1Ht8qiAXkfs44=;
 b=Awqc/KohCzuZulz0Q04m/LtoSzl5+2xIu+RSu2eTT45o26yS1NV8JH0xaS9T1G+NLwlUmi6LHntcTMd2s7WnsUCe7u3SnvkfVitjCMDKrQtx0C0h/8FnrwJuWbEEAZqDHWUAa+yBrqgBDx3gVS5asxoaqiFI6RShUaic0qJBjnQg4cqNcKR5a+pjVr8602/2i4k3XswTciixs1qnFimYZXv0Q4wKod8Lm83oQ/HkxRckIzX8lbMMLW/jQ+UovKopQj9ezLjWuFc8aFhDYzx+qE4u3uSZA8TK1/ycibgcp0xs932r48E6QjyXEjx8p7yqiRkg+WKL9vHwLpiEcKqpzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:47:26 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 07:47:26 +0000
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
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH 3/3] cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan
Date: Tue, 30 Jun 2026 15:46:57 +0800
Message-ID: <20260630074657.43077-4-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260630074657.43077-1-icheng@nvidia.com>
References: <20260630074657.43077-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0121.apcprd02.prod.outlook.com
 (2603:1096:4:188::21) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SN7PR12MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b9b2bf-277b-411b-8d36-08ded67bd40d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	JZ4WhCvO4mcNne5OJBhxedvDF+GqDf3iBVZTS+06o8efyXk9eQMlmN33bwieMAUPwe17+YKhKPi44P+OoQmmudQWQNvOYQo34AYK7igJrUUkCt6sO4t4QrevGf1crZ5HILW8TWeqBiyM+CPwYpMK/I/cXDs7IEl6aCMu9Iiz+lDkHnFrGPbuZnDzZws1QJZZhyw1D5aicNe/Yjtq4pAjd/rnJaMpBqtlIg1iL0LBEsnaCJiwqUYQovk+NjMIMammdM9RLQhnZ4WysgIWt/3FyCYDvRZmOw76kxftF/3fc5zNHmQOjC84cDtcrk7+CKNGGB7EkijtvAdV/itt63tXlEG2j+fQ6kMGIG0nD7mYpehG9ylivpMW0//+W2cq/mMdds0TRPgY2/Cs1NbUDta0BJG/XlQ/Omi5v9aNIL41URoifvqHL8RcaVKw8f1iWf2LXHU2zVz2CLgwLDi9W6i/h9fZIFqVmEilnfRKKxC8DRHj3gxraa6XIwHEO7AFNJILI9JPQMC4Mo/kzD8TJlTQkvWHi33nQiR5Y24fEnKo1/sqjofLH1LBk/kt/91S0Ch02EJV+3XP7+/H8mvbFRlskfsf98yL8WXYohPrkAvCDH142CSyy44tMP54+cqdhO/EAPjek+JdqpZXjvvWgeDannxLfX5Ma/SM11wT2PFytNQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EBRt75w5hbzhfyIFFmJqNBTB33pc3bXA+HPez0R1bZ0CAyGuJDoKj3yqJMCF?=
 =?us-ascii?Q?AsnBuclhMUzDEXqCiN/qhP3kLK5Wh4dQ+pEbuKPMEXnsJY8p6a6m0eJGLvUJ?=
 =?us-ascii?Q?LXglS5TppJ41xelNO7r1D2We2CqdcAXVi+OrCMQVZlvw23JagFhlf6MRvNUk?=
 =?us-ascii?Q?3lIeFGiMcxO0IQpsIebOaWanR0H8vcI2q/XbV+EyEbMzFLUsWvOWICM8PO0Z?=
 =?us-ascii?Q?GcwlO8n0nlFt8WRDMczqfbwvFFvsfc/RJ7xPjH7MTJrE0AjhI73gl0Mrim99?=
 =?us-ascii?Q?kBki/lpDXl+PI1bSUitiuH9+hIyTEk4/vP9SLpLwNXROjX+Yhqyg99yTyiSQ?=
 =?us-ascii?Q?WR/h7kDrtsqD0e0v+Beq5Eea/Hqri0lD2Hh6Mt+uug/G2B7/X6z7/UHb6Pzf?=
 =?us-ascii?Q?GKM1JNmiWQICkEHJcCtm6ZtBvuiwyYeVnBUN0Bo0du2xIRBPaXR75yVi09iw?=
 =?us-ascii?Q?9Yn1w1Dt3pOKd08XvbJ6Jnlxrl7fQSV9XtxAhUatoIyFIOBW16DGZZ1c9IiP?=
 =?us-ascii?Q?7KYi7Lg1HjrxAMDoZaqZagVrnWkZwlTDv3hGv134An2buPyStZGooCNoa9IP?=
 =?us-ascii?Q?Nawdn7ugs9f/GNzkypvhTXTJZJmIPwvlnwbllvIWareeYsISC9WrnRbzIdJ8?=
 =?us-ascii?Q?59nGg03gYbGC9bz1kKqYY7mHpL31LL073CRNGpP7hB8io4hEV/NtNemYiAu3?=
 =?us-ascii?Q?FsLvjk+fRyC1pRpuRWxj3GNFYgAFX744IjFYLmJrmW8Rim3QW7aOWB+YpmMd?=
 =?us-ascii?Q?6VOmo4s+RT4dsEheIgbws9HOquRtql5/A5QbZ2w8wU5FXail8kInfMO/uhys?=
 =?us-ascii?Q?8ilDbniIlLPxFNmpXHZY/Ny4dG12M7fa1YcNgmLYSJYdrhBqxANxf5yw/xtp?=
 =?us-ascii?Q?Sk88YsvERMsKOCsqef0+x6jtWgI33obo4L6mgkc1cPI7GOQDqDO8KcIeHcdl?=
 =?us-ascii?Q?gro0FFLpc0uaRt/CXcLuWux0BUmzDncnZrleqr7Oxb9SPv7fA37eQS0kjQOK?=
 =?us-ascii?Q?Bd6NfinrZMOjRmxJqg6hDEvRT3NjlIZ6ZHk7H9tlJXRTxJfIYLLZcD2i0MHr?=
 =?us-ascii?Q?aAio/mVTvYhT1w0e84b7iN3ei1M1pJ3XJNg9lT2xcEHCqLdX78GZe7KY55rn?=
 =?us-ascii?Q?8XZPGCrwa2xptLl45XM/EJGqu89ociqSaVt3HHWi0BPjS+MNgaIhO2GXhO0/?=
 =?us-ascii?Q?QoPYHUCEQrRU8Yy/x2/5ACC94Z8oPo89hMA2fzUKtLfHqYSzBu94DNOOPyPu?=
 =?us-ascii?Q?me5Mcsq4VwsvdB+pd4lFw1PPv6Z5b7TqnEw6EooE/wG6FSRe/9Ut9W1kr1MU?=
 =?us-ascii?Q?YQCx/DTqANdqlAPLPMyDhLLYmg8P+rMPD5oLyrsY0E9XoR7XPODDbBfymbCu?=
 =?us-ascii?Q?R6OYYBKTSA3YYVCwG5ih2f1QV6iNg+voM0H3DHfPwhxGmT0Hl5JjNY3P5jR5?=
 =?us-ascii?Q?RDcYzgcZUrXuTeJJpuP5y/0C00+J+YwfEU+CYhCv3NdJYkk4L7DyJnThpsAH?=
 =?us-ascii?Q?p9WfpADL5I+P6LSpGeQDj+WXtgZ0627WLGHWc9rtgEcK6ADz7t/pqboKcpL8?=
 =?us-ascii?Q?G2DpjUIqCLT7LzDHS+UJcd/N5KOIQaWf5LxI8tDWn57eKy44EJzP6xrrdtPm?=
 =?us-ascii?Q?LBJbYau2br9HPk3I5PnbfqiNCVv23LfTSJ8Tk+yc4xA/sZUERO13rnn3BAIk?=
 =?us-ascii?Q?1HMRHj3iwvcfnj/UVmqRmU12Ywer9i2gRGxRP3rwOejle4s9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b9b2bf-277b-411b-8d36-08ded67bd40d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:47:26.3561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmYEmni63aUDA91md2fjiMBQOUPF0AFZ4NVmCBeKEdGUZ4cC27ROlvnMECIwXAoFob+lcm71XlpA+EC232WRPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713

cxl_get_poison_unmapped() tolerates the -EFAULT a RAM partition returns
for Get Poison List by skipping that partition, but left rc holding the
error. If the tolerated RAM fault was the last poison query before the
loop ended, the function returned a spurious -EFAULT and the poison-list
read failed even though enumeration succeeded. Reset rc to 0 when
tolerating the fault, matching poison_by_decoder().

Fixes: be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/region.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index be246fb09c99..52ba8e9e4288 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2933,8 +2933,10 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 		if (!length)
 			continue;
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
-		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
+		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM) {
+			rc = 0;
 			continue;
+		}
 		if (rc)
 			break;
 	}
-- 
2.43.0

