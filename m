Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42921241696;
	Thu, 19 Jun 2025 05:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750309482; cv=fail; b=ilMEpR4yJKKs3CiWCJnXZDV2SyjzXGf5CnSp/RUYZpP2vx1RV8Qu4E7UfHJzFapI4a0cbpOiTakXWTWbVeTcgH4w7G3c2e84GhnWzJBDRoAPzalJbPXctg+Kcr2p9O37uDVZ5iIOvePioXVO9AiugWjcnAL7UB9/TmkJli2U+sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750309482; c=relaxed/simple;
	bh=RQwpJswR3W4YPV9mRDhvq434UlFUk1RMTW/cNuPzrZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HThgXyf2yeNYRn27JYxXqgh3SUB7xdRRkQsvMKJS3n1i7494XttVOvMbgydvt20q/i9Mlzf4+ZP5BO+/tQHbFakbZFGilPBpdVx8SdjWJJyh9HLEA2wKvO3Znd2RT0RHwMYcnwGwgCkK1EA6RRYnFh/+i58r8jCrqIndMGzBVpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AY4zKttu; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AY4zKttu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750309481; x=1781845481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RQwpJswR3W4YPV9mRDhvq434UlFUk1RMTW/cNuPzrZU=;
  b=AY4zKttulFiwrPHIXi0qgj4Jb+7QOzSDoEfDksa0rIx7HHe0BmwGM7P8
   Pz+r2O2SkPeniqMxNax71rKAy7I70LFr4KG6PpKoUbhIOzduYuy4WSZtI
   lRnTUoWuJ9R6wdgtz+juRIKChIam8f0SHmgrP1yyeCLQ3GqCeBVCl5YjC
   78NlOa3KuoRKFolfYEF0dyAxd62Ae+ztDIV2IawJKh/eq+0s7iqFof6bh
   EJio01MIvN+O6RJrr74DZbm5++PWp3ik9zq8ax/CPLO0yuMnU+Rdr09DX
   a7+Hun+EeNqva5u8GOs3q/H05secXGPusZTVVQFDICIUMB3jwyjwGKlWd
   A==;
X-CSE-ConnectionGUID: HOvMtG59RACrxNjC9WQnsg==
X-CSE-MsgGUID: /dRVZATrTg+lKt54hUjYUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52702200"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="52702200"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 22:04:34 -0700
X-CSE-ConnectionGUID: LlS8CE+hSwmPu5EE47Ph/w==
X-CSE-MsgGUID: 54LwvhaTRQSZQnp+Bi/t3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="181373558"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 22:04:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 22:04:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 22:04:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.42)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 22:04:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TORPH3CG+IKDYeTFp4QRJ7QqRW1UMV+MQG7/074P3NntFg9SWlvcx5YUumiPQgx3s8f6m7SGL6GMwUNtV+N8akdbZDbovcTh4D28lwCUBI/B9swVx19ZWQDnaATztja+gjP9IoFHRGpM2iQvBnva+79S+2fPO0da5hbw53FWGjCUrj3CQyKj0kma+NV9ldDTMSt6n2LTW+thR60vfeTOiPl0gMbyfsgqajaxBVJw85x16Lnmj21i5KInaW0XAoerojg1YSSBG9y6WLbIpziLOi467kSLxljQHZxlUFMASA7N6gBlGJfSRe1EUHCZg5tIkWEsxcXdgArOruaiNdmn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R897TBI1/7eUvV3mdqm4x3pVyqXwgC4Sq7zDaH81WBk=;
 b=K8bwBuG1Jzf8Qu85zGKGDYCa3TpPPrRJ2zN7MyoqhMHiVhGHaDvjwMOaDqWNWjNUsi9FDOo+e7KuWsMNXuyEQu5+qHumuDDfnUTG7kjVs98PSpPs9YjWaE4bpTK/NCGjKNYfwMVI+btPxKK76WE9b71PqK5f8ypgp/V4VGqmfmPfVuu1bU6j3awUqXKuAM6IhTYwCyP6aEcIiueH5o/PueVNx0WZcpFaS08O3dAAgoGuyhlU3EaSIAQEtcI0PkQkZ+SgSFDbC0lHDxWXpDsWW0yo25LMB8sfUjzJ0sHwnxKXZq2U/4BaXlWPt7acJoHPgV+1HIOlSFXIzcaM9f22yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB6819.namprd11.prod.outlook.com (2603:10b6:930:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Thu, 19 Jun
 2025 05:04:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 05:04:24 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2 4/8] cxl/decoder: Drop pointless locking
Date: Wed, 18 Jun 2025 22:04:12 -0700
Message-ID: <20250619050416.782871-5-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619050416.782871-1-dan.j.williams@intel.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:a03:338::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: db782686-bca7-4474-fd55-08ddaeeec21b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VfTq7JS+i/S53rsrDZU/I8WuJlCzJBdxR/A7wnSCGhwniIutaIEzLrEFWkei?=
 =?us-ascii?Q?l1LviEF/VNxQJUGprmkGClQgZrubPWVliCyHWO5mvf/J4DZOI0gGfcxTP4CE?=
 =?us-ascii?Q?/kWbT8gMTXYoG9FeLuUMWIwx1930SbzM/C6eBoecANmthlYio/UX2iIykmvx?=
 =?us-ascii?Q?TnYcKvlPyfRxzNaY+4WnPgiyBxCsO1QEGBDwJ3UyAOcnzCwhXabzLA0fRZox?=
 =?us-ascii?Q?PbWGEWE83zp5v9QAoEpH9LsImGni9tyr1khWBSoPt0vVP2mJLtaGpd1teTVW?=
 =?us-ascii?Q?YyBY9YgSjzgEhDIcWjz9hxzsoip12UagE4O7OeZGsgmGMO/WNB36y2iu5+Gx?=
 =?us-ascii?Q?mMGEIfk6BMeV6MlpL3BQo2MMD3bOUECTYVOPCNAWKEhks530J+C2gp/slT59?=
 =?us-ascii?Q?fk6nV8VHXz3MZRi6TvrbR9B/HR8B/G2q+tS/lSTA4fAdNLrIR+fNn7HMezas?=
 =?us-ascii?Q?yhekTNqJCR1YPQyCSbozFd1cZwQCF9UUsC4d3n+r0E3ZX5wKptoItM7PCbAN?=
 =?us-ascii?Q?7I5XaJ/cA+og8T/Pz6XFfRvs0zgAkvbxEzNqYLj6cJ30Cd2o5bRA/NzXyJLx?=
 =?us-ascii?Q?qOlhsF7deu13x5qtjZ70FVEjFoIFmTnb5GGEBT8JrCiqn9u7FdpQWiFiSjbd?=
 =?us-ascii?Q?0dtqHn2mAx8Y7d+iaiavdAOL8Cr1XsbhPhXXt3QtEtMB8rPPio2jA60XtqTW?=
 =?us-ascii?Q?MCiIVJYhH478XVZ7ABwN8LN4cL7XkiKNH/VS8iiaoL0uhrGrHU25TznvD63D?=
 =?us-ascii?Q?xWY2UaY3Aeyjxttn0Awli5KojdwBierruAEuTyTTBfYZJnzDr1kmSO5w4+9d?=
 =?us-ascii?Q?hGVcTyiW99rMrlcAj1KeSqaLk0+9aIqo74c3xpsvQ4V/I5ok5w3Rv+1rCMuH?=
 =?us-ascii?Q?U890bJC+V1kAutNRE728GVAEziAm/s5niSrAonHvuEqS3w/lZroz5OTMyISL?=
 =?us-ascii?Q?2txMRb5F3UzodhbuR1DqI3Ssw3xihaMmX+kNO6yrlLdv1aEYTLITb2sEDBUP?=
 =?us-ascii?Q?eViEpdVkGLYpi4bSAYogqwpfEyQBpX/JvYXFsxg59wn84ENswL7FV2Zhf5cw?=
 =?us-ascii?Q?ujgRBKFmH8SzZmMFGezmjsCtG+fURlLJpXWJ3dL0piXgDELvdFgwsojR+Yky?=
 =?us-ascii?Q?ICrxgSEyMZG3Ey13wlGHiZYRPoeuQKCpK7VfugMD/w+EQNqycoZpn9iDB9Sa?=
 =?us-ascii?Q?/Itb41pVfH5h2LvATZikyLXz4zBTlw3J0TKorchXI2RDJnH4SfI/y/J2ccGD?=
 =?us-ascii?Q?P/Z4xBv7axlfw8BQeXN2YDaaptkfAfy7YArdQ97X2N1NmBp8EE8aDzbd7lau?=
 =?us-ascii?Q?WviOKrqARdWebUSb5hnhsZnKQp4icrn9kboRjY8MdOsA5mcmxSMPTgas+qKj?=
 =?us-ascii?Q?FF5+1pNLe1KycDfL5FlLTRV/DUN2+bXaQ+fJakcuHERjrLmvq+LyfVkYGyhk?=
 =?us-ascii?Q?/aCNb5mIdos=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?clw3A/KHcRklvCtkSP731R4P9jypGYqclS9P/BR0gtpBswTVon4Xxm8yj9bP?=
 =?us-ascii?Q?daMtOs0Dsn1T2M+n6TcOskvUOCoIQKdKB4CytcNN54/ZgyFYpbj6UsZfqaPU?=
 =?us-ascii?Q?gd+U3M6L72dPg3ZmytDXpAox1q5URtSJU3ywM+EP7W/MVl2AdcBVIlW2xUXp?=
 =?us-ascii?Q?7MObaqBz8E/mwU8b+LSwX++Bx4vqW+8LliLc7M+mPBSogcoHIb9VlYTbEfg0?=
 =?us-ascii?Q?SFOg7QW9oejhhdaDThvv+PyK41XE9mmYzTNCCo1e9Z24QjM+jOcLSDNUO1ge?=
 =?us-ascii?Q?o6oHTnjxm/Gnc432C9V8xVY029Zyafs51Rjbz/zpNEWmc50FebSB4QtudAko?=
 =?us-ascii?Q?hyhyMB6VPV6wZuuAmqs7d7DgX4+GJGggjMRZXr3TAAtbFsFlxqgsDYmB9xnc?=
 =?us-ascii?Q?psvMPOEZwvHKJCyPmTGh28utfYkDadVACqQOT4+zcZQrg0XnOON8zJXWP1HE?=
 =?us-ascii?Q?Vj0L8R3kWtPpvTd46sUhzMPeV/pKpNsceWqzAYsBdi+qHh4la9GMVpA9Id71?=
 =?us-ascii?Q?jciO3h4BfwJLEV9KgRMHZz6ib8Va8e/7piHQcW8XPb+TUfZtLPu9nd4konfD?=
 =?us-ascii?Q?iKODfET5F8FY0rXgRNov5ES8C8BDHa2cblBIzgogC3IX4DjeaYHimsY3OhOE?=
 =?us-ascii?Q?W7F7Inbhral7IWIalEcx8NQlsnYK9Jz+mq2Atnbh1H0LFmWN0iSPIpZWUf3I?=
 =?us-ascii?Q?NSr9I6mIkPFGZapAKqsk0hCPJzLDMcF5hsPFqXIFjl3GluFoEgUwLV6wwmDf?=
 =?us-ascii?Q?HtjmVvUmM6N+ikn0vxDNLdWjZlGuEYAQYlvwymTyqHjzo1rN0YefreS9cyGH?=
 =?us-ascii?Q?Jdf4EccQFzFLnLpeg+Q1pADElmEhsz/ZAoizkou3A9GXOPpbPj1wrP8I4cJP?=
 =?us-ascii?Q?eqg5ir7ZEh8esQLwfCNzARqgB3J8dA3JvPzsQgF8BZUMzC9fBncqf0vHQWlH?=
 =?us-ascii?Q?cu2Dl5ZGBi68oHLITIJBwqqf5nAFPxgbEGKCvTnEvLomCD+VHoVTpA1G/vdV?=
 =?us-ascii?Q?Tz67i/maIKhT5VAHIRqVavaXbF6gQ8GpXwgsnwNn8U0t37OgFRAMLQLnYpFr?=
 =?us-ascii?Q?g6RVMTFfck8k8aTBgUv+yogzJ0SHT4EVo0Bl+iTHctYKDYF41ps+SD0i7C+H?=
 =?us-ascii?Q?9zwSQY7FBQuEOHvYgDg/X1zue3fUvIoRAKmsh81j2OCD9CXhFCtXq77LllGv?=
 =?us-ascii?Q?xHu5TBHuYBfbYQtR2x1UbVkcopFl3vgzwa3rkEnYyuqUKQULQuy8U2JENieV?=
 =?us-ascii?Q?Z6IY67tmkm/ZB2O0u+RQ/+ztqqeagyeKoL7rjXpgpmvSrB0WZjs+eqbS6GWb?=
 =?us-ascii?Q?BFN4aO+vrGkJhBDYnDtmVj7VG3rNVk9TeHx3ZVFLRVvQjZmd1JrYfvSuYInW?=
 =?us-ascii?Q?O0NkKPf2zmZNNlWZBXA1000JylB0ez1ltUoiAKGOuTESyhxXbx6c1i9Fiqzz?=
 =?us-ascii?Q?m7rACFteuGBTvaXPmtn0sfXLfSnPgBiDbYKwwX5nhuq3pKoiK4PX5mfEzjJk?=
 =?us-ascii?Q?46jMZ7j7Jq38nWbXM2by09wSpoUrCy7SqXX6dkv6k/pwDBM8mbIEfz/3A+Tq?=
 =?us-ascii?Q?ImsBi8Db1QIjyVRMbhdwSaC5rBZicDfJIUnVm/DbyhzYi7Z/hw48sd/Wno0J?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db782686-bca7-4474-fd55-08ddaeeec21b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 05:04:24.0824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P29yHO8a8vfRajowe7MwFTDDFTS4NLjI6RGFbg0RSkeWZUV3C9Yxh8AVsOildD3gwjHt4S9SJVpcKZvjquforumOZO+SnEgxaaiNHNN/K9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6819
X-OriginatorOrg: intel.com

cxl_dpa_rwsem coordinates changes to dpa allocation settings for a given
decoder. cxl_decoder_reset() has no need for a consistent snapshot of the
dpa settings since it is merely clearing out whatever was there previously.

Otherwise, cxl_region_rwsem protects against 'reset' racing 'setup'.

In preparationg for converting to rw_semaphore_acquire semantics, drop this
locking.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 81556d12e9b8..e9cb34e30248 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -914,7 +914,6 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 			"%s: out of order reset, expected decoder%d.%d\n",
 			dev_name(&cxld->dev), port->id, port->commit_end);
 
-	down_read(&cxl_dpa_rwsem);
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
 	ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
 	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
@@ -923,7 +922,6 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	writel(0, hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
-	up_read(&cxl_dpa_rwsem);
 
 	cxld->flags &= ~CXL_DECODER_F_ENABLE;
 
-- 
2.49.0

