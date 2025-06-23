Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D335B288509
	for <linux-cxl@vger.kernel.org>; Mon, 23 Jun 2025 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750701925; cv=fail; b=FGGU97I/BgoLWlfTmrDXWG1uT3wRej1JOb6vtojJsrDtQRuKeSd9JAK/d9m+3zA3xSOLuYjrnpw4MEMCB5M2rxv9ZZpQH2MzmYsaDBLIWZR9FNp9yavlbeisfgE8CKkQcLghBcd+bH/pbXmB6CwZ/kFmPdSmFk6mWcLaaIrsr4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750701925; c=relaxed/simple;
	bh=nOCZ8aYjxLLHYslzN2GLrGvSddcGyRZAQpSPJ7W6GBg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eHS176rGaeTdm4lMJSHU1efz6pMicLD8AFVTK/z6FQbgQMstEUzsFpIl2mygY2Vtv6u/1fVTVJlQmd6hqESrNHqjtuYHEpfqowIGMqfZYtuCDECJ2nw3VmczkInol0+Ud1VWbyetU8dL5qO5+fLjVrEh86vXTtMHO5DzEFquFis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TkzM2brR; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TkzM2brR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750701924; x=1782237924;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nOCZ8aYjxLLHYslzN2GLrGvSddcGyRZAQpSPJ7W6GBg=;
  b=TkzM2brRLzb93+OM8qitNytBLhkps/wHaymx2PBjMWdrvP9Jjl7eIlNK
   AFdpIaWKC7XS8BNr0tfLbf2b3wbx/yJSlYP6ySoEdmZqN2TPPKF1tHWO1
   mtoRAPJ6Sx64ub4tRejwPxgYu6T9YYMvve0zZ6hA0HpTHNQizaX0uKMSp
   eAGXYHDE+lFCue+/MVBfsL+gfArK/Y8sBvRLTLMhyUgoC75TfV9fqGWCq
   RmQukpRvCfmmGy9MmVKfqd7LyR4Tj3BEN03HXJnm67yCKze42OwdKUqe+
   4kia/94uzg5avSue7RiFfh7Xo9XpjK5NFSnLznBNLKP/uGcl9ZPD8/zAp
   w==;
X-CSE-ConnectionGUID: alhUCkbbSwm4ND0OQDymCg==
X-CSE-MsgGUID: 5VehDPryRDK80fk7t4DcuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53050867"
X-IronPort-AV: E=Sophos;i="6.16,259,1744095600"; 
   d="scan'208";a="53050867"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 11:05:23 -0700
X-CSE-ConnectionGUID: jn54f6QxTkqk3Nc5LJ40sw==
X-CSE-MsgGUID: PSGZx12NTEOU2eK+D62r8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,259,1744095600"; 
   d="scan'208";a="182716592"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 11:05:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 11:05:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 11:05:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.86)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 11:05:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRIIrHYA7kxm7eygG/sjkN6P0vvBXfYurqJd53JJOXKuAqk3vYFtBmshtjigruDckJAzllpo8Co69NY7vlvpZpRp1S7pyEAsG1n74ed9iTz9PYsFDrT6nkVWqNKG04n2bpcsUif1nEzo31stX9N5Lb1zOsduQSSpAR0GS6MF+eh1WsDu2GRQP8Bq7twt8uvkPbNP6SMu+IDyKqjksmwCB1uaW9OGoajowF98chwbZcA+LDiexZz3aVi7oKUBaJ6Gi/tY3j7Xts1QbLl0+xgxAtzWZLVHX5Ob+KG/ynWPEQeIxXt2JblJgtpWZ1d+KIzaoCkEjFAUIIF74+SPnE21UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFvpS6BzLg153rb2sg9oKbUug+DsGf3QjW5bMX3WIk4=;
 b=WLXWrAuQ5uI7lJhfwnbvO0mmaUc4dd42kKDvFecUYgBWFDAgcek3dQljDu9nRrMNgMP6agoETsgpwqs70Bu7o4EMwdCXpePsqIHMBLbEeIO5vMfOX/RCy5g7SA4DVtF5mJx5mmCgER8yo/EHSVasaO3m/AuI5uT68LSHtGbb5RRqQB34vjxqjwpGsQHmZbA98u9l4Ub2nONHQID1fDHIhhmb0MyCKaQ8FG83VsMtZveqhEvZyj2o+7U84U+lbAUXXmkW5VPFZGyrPgeg/fBoNby7H4sCNzXz5gpOWJA/teV0VLSvxIWMmABmQSvKr7LFAT0dCLcOHDlPL1YltqhlDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by CH3PR11MB8591.namprd11.prod.outlook.com
 (2603:10b6:610:1af::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 18:05:07 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f%4]) with mapi id 15.20.8835.018; Mon, 23 Jun 2025
 18:05:06 +0000
Date: Mon, 23 Jun 2025 13:06:23 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, <linux-cxl@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH] cxl/edac: Use correct format specifier for u32 val
Message-ID: <6859979f5e35c_2b363e294c5@iweiny-mobl.notmuch>
References: <20250622183919.4156343-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250622183919.4156343-1-alok.a.tiwari@oracle.com>
X-ClientProxiedBy: MW4P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::12) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|CH3PR11MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: de59360b-3851-4ae8-1262-08ddb2807bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jE8j+BvTq+IpjcsRJOfnGDor1BIgxBMzUXqJwm7fl6joS+vyGOFKSHpLXvxf?=
 =?us-ascii?Q?8gdn13Lus79Z+2Dg+1lgHVS0O76K37+0Zy2CLq3W2KPZHQrT39NgqbIUSIVP?=
 =?us-ascii?Q?m+t138JId/cepFx/I3zhCA9UkH7md2plxJrk6QrtmmIq5Xb7gyZFNT2Ng6+D?=
 =?us-ascii?Q?tyaquEDY/5CyX5OsSmYvw3zvqFkS27kk/invdkzlvMVonkd9WHn82dh65tPI?=
 =?us-ascii?Q?0moyIRe6MoQAp/jn9xz1/J48/sI1aeX1bulnG0mDDVrHKflp3muR18RjB1uV?=
 =?us-ascii?Q?wg3ih9m85p8Glrd+2UxEgZXKfpcIpqhK3WACzvp57y+q+/gA8HPG1ZULP3qv?=
 =?us-ascii?Q?fWEtt+QgpOr3U5TsM+RB2X98NA9HoUpfY2+dP2bJm4RBLy7NqyFvwpS2aHm3?=
 =?us-ascii?Q?0jfCmLo5SxJX7Tr4QWOlSYDD+QsVVFxcRxwFRp6oMo4lBgb/xogjcU14nN97?=
 =?us-ascii?Q?Ba5M/6WIb5QyIQmCZXyUi/rjk+1fgNc03Dgzz4SK++517ZboR7GaniiWRgZ/?=
 =?us-ascii?Q?7FvW6Ug2SITUEDeOMwsS7ueLuxdF8iYYwFL84bOnetrCOnCZAw83pIN2rLIh?=
 =?us-ascii?Q?X9RLeu3pzjQjhyBh6Nha1MnmxAz8rhDGsC0hqqNA0+T8NIcIxUsILhdbLO+n?=
 =?us-ascii?Q?9g+W4bGfLhQ5vQkY8mEbi4pyQNCxcuY9IyycsTkQtlPn712e1c++aCDOtmXW?=
 =?us-ascii?Q?+FPmJ69v5E9jy8Vmknm0p2emaSG35dyfBTCQLy2nS0WROpp1sd6ERbu8fDFO?=
 =?us-ascii?Q?0BVaH3oVRmKh9nhEOVkJyq7OWN7n/ZuzIYp3+9gr4E4oE4qpdp676O8S/NY0?=
 =?us-ascii?Q?B0TUh4+UkqdjhKCDTiCwlJkoUr97CAF5QupPZDfpdwjHJ18sDs2cD1M8mAdh?=
 =?us-ascii?Q?kI68jYkhhAjwfJorA3Ok4nR8dbljxLaLq0LXBAhB2XjNVbqiHwPNIPF9P3l3?=
 =?us-ascii?Q?5N2mqs5sl96UccWEWFV0uADQUNLi8jfLJxiW4i8xts+HSG2edjdaNf+cqAE3?=
 =?us-ascii?Q?TdhWPHZPWSP919+BqWRM4hNpdv3ZcuefmhS2YSvWBPikvPG2Sh4E+0yVT+pz?=
 =?us-ascii?Q?EAN7vban9nmIOWmibCU1FZq0d70CTcJ1PsmITduH8K5Iyskrkjr/dYcI4Wed?=
 =?us-ascii?Q?hxh3B6H63V7n8/t7G3w0FCXsnCUnolxgg7Q0srm/Q4oy5hkiIF0oDilLAWKv?=
 =?us-ascii?Q?kZ8ZByxrDcwqOeRQ1Vx4eDHJ8q/GiVT0iDwY0lEnwjSGkpzqiTd+7mIrMWc9?=
 =?us-ascii?Q?B0VPXdmIdJLurp5xRwZpqZsCouxVTggCUSxxIsxNwMNnQPo+WQB57PFp1Sgv?=
 =?us-ascii?Q?fwLooGekBjtuSiw3nwgM2b2cPkyKTJXUlsdlJVKcLK13MrbVQQDRIqI5X9rY?=
 =?us-ascii?Q?UKSADopCbsoRLyyo/Q9+H97+4Oe5H2HQ9X4mNS7QU4dCUf47NGxaxpC0MATW?=
 =?us-ascii?Q?V6fHaKG/v6c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6rQxyGQEv8dv8Y+NWvdiSsIF/CSie0lfq6eS6hHkCNNtYrHdw2akEGdkW8p1?=
 =?us-ascii?Q?lEQaZDAbWf62v4SYxeuPcC1fsLDaegdD/n+7c5PVX2HT1VBnP732OKXTbrM+?=
 =?us-ascii?Q?ELBkkU7rp7D9+FqzgSoo8P8LOCQyXvSf7kK4r9FEFbEcfdDWo7Omh7SOAshV?=
 =?us-ascii?Q?BGpgnME3fMe3sRm4Cxx01n3uhJzn/qZSA+MFjna3247TQuajWQ6sS1v+TB2M?=
 =?us-ascii?Q?jN0u5bm4n2eobcyEhnHHEgWYBhfsr9FxdVgAFAjmiuDAH8/BGJqNlxXEErBK?=
 =?us-ascii?Q?5jXn8nIJo6+vLGMXhzGZktQ2LjEEEpQNbtPAQtOWRHkq1Ji5x7iPnEQOhFPd?=
 =?us-ascii?Q?kmXbOs9dOjhliNLviqtN3jir/BM5vhEnEO7fL00pzl2POl/Y1LfATsacSh9x?=
 =?us-ascii?Q?ToNT4ae/4UvgvcuKJ7FQ0OxPT6Qh9ushYt/GwMlS0VKbScPur2mC5TMtCrTO?=
 =?us-ascii?Q?jIaLJtxUCFilkulVhIbZrgUsyWvoELsPag2a71Wkjx/gXC4FVNVX/VTmWEdn?=
 =?us-ascii?Q?bTPRXkdAwrwWGIq9QxbiDO+ZnwvjzRk97uXugWC8VkW14Zg63xl74lH2ro/g?=
 =?us-ascii?Q?0/W2XV82R3BRNETzhdQSbgoyLP57MnSo+YgS2TFUYdu9N9NF37qA/LO6nG2l?=
 =?us-ascii?Q?twaewZtez6E75uj7sBM4A1tVryRZ5YbLA0OpzTgzeUPEfJ10vVCEW3iLjYyi?=
 =?us-ascii?Q?pEQFuiLKzCdjXhZwJnWwX0eBTnLv04KFXMB0naveNyCPxGTZAobesknZt6Ub?=
 =?us-ascii?Q?DvAKNRW0gOGG87jcShmXxeczB7I5retMz5gZXcfzAmNn0P8vOzLdmb+lOsCl?=
 =?us-ascii?Q?qwKSrYQU2JWL8qUDGgUwBgHJa9zISQee2CnCkTRGzeRSQGxQxCFWkB7ydL5g?=
 =?us-ascii?Q?gqIbXv88j8w38zR2blYYb/yeLbzHmqrxwZVXGw+6yjuHrpwUJ9Fat4unzMPv?=
 =?us-ascii?Q?9xpcIl72WfEDzUbj4Zu5Xppw9mBfJurOrXbfiXM+uSvUksAi9+TMTSayt+qu?=
 =?us-ascii?Q?57vSXFlmlSUWDL7uReKRKLCD3C6BpZbrfCCHNi9+WIITo8SGe7VTDSTlSf8n?=
 =?us-ascii?Q?trtqCqRgZlPkxv706PdHOWbDghoqnY4hg2hm0LjE0/sQXyaLTVN0Qq/1pIdM?=
 =?us-ascii?Q?pEIGxBkFxKFnOSVAUXtFqNPa6JYULtsWn0k1sonDoQ9ontWt9hNC/24lhkYg?=
 =?us-ascii?Q?9umZBJW/bp9P3X0bBEh1b0J1ADfrfhji/GtWI96MdUNrg50Jki/o08XURRAG?=
 =?us-ascii?Q?VmcnxtBtKsvhBInSiH0NbZfNEcKrI4tz8POR0lQPUnqjNJi7WRgwQO97ykN1?=
 =?us-ascii?Q?J5DcWSK0s1DYIE4pU++WFw2stGimA6lmPisDgwUpmw5J7V4u+GUOo6FgEEvl?=
 =?us-ascii?Q?PHSCUjrrEhj5mqUYlZJVvmhyYQHFj5Wcz1pAmTF71lftWN8cFDla8Yfq44JQ?=
 =?us-ascii?Q?r60goQRwoKbmG9Qlry9Pkt5G5Piqe5mHD56uWBsMeZ/zhTfPIaJ5DRvMeerL?=
 =?us-ascii?Q?c0/IIMP/8p6TR4lPCsG+XYfrlK8XWXIh0P4NJ7Ysx4ORP6AMeHATQy2V5R0W?=
 =?us-ascii?Q?G/ulA6JFMpRBLbt3ak7cYnpVhZN5vwD4gt0UuOH4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de59360b-3851-4ae8-1262-08ddb2807bdb
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 18:05:06.2520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQsQUxxJpMEgkLyyooL2QvYNyndMiAI5zEyDaR9IP3y7lWZ7sl6KzgPFERryqLVTX9wv2OU/KcBYcrkctbRp1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8591
X-OriginatorOrg: intel.com

Alok Tiwari wrote:
> The dev_dbg() message in cxl_set_ecs_threshold() used %d for
> an unsigned value, which could lead to incorrect logging.
> Update the format specifier to %u to match variable type.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
