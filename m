Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD31B205E16;
	Fri, 10 Jan 2025 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736531704; cv=fail; b=IvCQcfKrw5XoThyYbkE5iDdie2IykgYG5WykOcoNoec5gsM90npgj0Bhy1YXj7HSLj02nk4Zsxfu0cgB49PkscDGDbrObjp6WQedXOVnrVKBLgF4jGT0Dg2Z27wtUvogARlRPyg44rbG+I1pHHXxIA0lxwo1z/2/FQjHnAVm6PU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736531704; c=relaxed/simple;
	bh=gvP/XBX+JLqTlcWaCNxaQwfUjmDfWB8o0BkioqlIiMk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oqtMAESSruFcSKrkWPiagdr2EJuEcUOGuTIiOXjJGwkyNRECJ0ceDZnCnmfst8D7X6tWC5l7VOZcpk3ElSpDxEMgAlSQq2iPXt6E3iDWHBECJEet2TPHWrZ0a3KaINjX5M6RiFng74mAHyHShL/f6QgOgQ9VAxeiHXez69HJygg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Frm5S/91; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Frm5S/91"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736531703; x=1768067703;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gvP/XBX+JLqTlcWaCNxaQwfUjmDfWB8o0BkioqlIiMk=;
  b=Frm5S/91+HSRCOeoxU///35sEjfz3P/TDcSYul6jb9KU6UPBX8MFEY83
   W+EPECTXBNwEuFxON2PEabnRTmsCQT02ggsTdsMhEKWntabDYoQiyDLuJ
   wwUvuo+Q+oyt3JBILqYppnklW9Pucdcn2+r7CKEKMnKFTFPyWQt3CzuQz
   bzVIQIQJ/wn1VDHtElvN6xMSA+qj7k7cPOcUJOfkiAKkW06cZlt29Ig8m
   FkDxdtByOVO4YXCIozayMEQsreDR6r50bCX1ow99bnAzJUCodbcF7LU0U
   KQQdt8ga41Krg5gHg+MoTyoBdjwbNvKAQeFkVHbEMotTHOCeB4AFb5u/M
   A==;
X-CSE-ConnectionGUID: UNooKnBkSIqhLNq7+DSzhA==
X-CSE-MsgGUID: 02zB8PUEQMKyJ4ldnXcplA==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="36992132"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="36992132"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 09:55:03 -0800
X-CSE-ConnectionGUID: 6NEBcaizSdOv3OoZ1k60Eg==
X-CSE-MsgGUID: z/45U0XGTJOdcV1VG/c4PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="141091154"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2025 09:55:03 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 10 Jan 2025 09:55:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 10 Jan 2025 09:55:01 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 10 Jan 2025 09:55:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaPpFe4/8PZqds+l51ljTphXWZOnUz8mxJrjRJHkzTo46mYaYAUhxO5YYr8OcKRBwFviQvrJgx1bzxgxQ3DjUlJzI2x5EIrYXXw8TE9+24eYZjLtBqFqtOVsFESL1syvui3diIMMikFtW31iXT/kKIniZ7w8NJlutDPZANxk3ozpYSlyF9t+4EMAmcxkkpABPNoVO3jp3DB42N8oYtUFvVBBYMp2tC+s8OuUDaboeMtBk1A4Qmp7h3ax4ov3z0Snmgfc5xKLUecH+20uDvAgIZbQGdB71nJeqYYBHCPNgJQ9GhzqJRgG8cpGnTeZqy1fCyDwxEPe1THkPg97mAmY9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nee+zPb6gI6HSvbuIueWu8afwO5bSItv2eSpzMdXws=;
 b=nUsBfcnhNr/yqhSSEDs1iBHPL9jwkJN+6P/BKQiPtbicI3+C67v5BvFqz6orME3HGhPkj6kmo4Ujv10ayUzg3MRoAcaDuk2HIy1Iv7IiXMhD2IZ0bYQXPNhEPjrZmv/i4tBvEXcSQu/MtYFWw/ItNgVKSI2jctnOKbxPDv4OTvGOklW4JCayiCwYJB+mz6SaOgElGFJ2pYDfNX8KDjOOsCSFVT31wJOV+tQw2IvJ7lJUNCii11OPlmHFev2VrS9+2pawgAXQaJle9SLi0OT5qbuWhiqV9dVOruV5lYr9weHk6VGxoXRWo2C3xRy0t0D6DkWvHRJ7+G1N0Rh5eL7V1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 17:54:48 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.8314.015; Fri, 10 Jan 2025
 17:54:48 +0000
Date: Fri, 10 Jan 2025 11:54:43 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: <shiju.jose@huawei.com>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <nifan.cxl@gmail.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: Re: [PATCH v5 3/6] cxl/events: Update General Media Event Record to
 CXL spec rev 3.1
Message-ID: <67815ee3cb511_177894294a4@iweiny-mobl.notmuch>
References: <20250110115556.1654-1-shiju.jose@huawei.com>
 <20250110115556.1654-4-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250110115556.1654-4-shiju.jose@huawei.com>
X-ClientProxiedBy: MW4PR04CA0380.namprd04.prod.outlook.com
 (2603:10b6:303:81::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB5013:EE_
X-MS-Office365-Filtering-Correlation-Id: d2193db4-addd-41a0-8ad5-08dd319fe003
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NpzOkahi3o29H0fullAZnH0Pbp4qMCY3Ot/SpZfNomhJHvaBvFKvDxhFoPOy?=
 =?us-ascii?Q?tivB37sBPjnLXUgzrebns0P65IE7PIM64LB/mqo1nhrocfdKr0IYrzlXEsX7?=
 =?us-ascii?Q?B0RjHrVhBhKinEpo5GstmPz+Ojx3BdErsvdiBCzDwfl8r6aP9tPcWFjyzdfF?=
 =?us-ascii?Q?R9gEBl58mDMR9iRoAwPHZN3YzeXffPQ/eDF9FyYgHmOg6GoRhuugZMyux48B?=
 =?us-ascii?Q?RThLlQMDqy3knH8zpfF4vE8BnQl5xgeeSfRsiCyrplWUixwd65Z/lPbjacY2?=
 =?us-ascii?Q?toHYx70lniJEw9+lA3c26MsKI6FTv1m0jfZs7X7gMHyg7nmWCDIurz/T0kth?=
 =?us-ascii?Q?a/iWV8mv8uNnapIaXYRXtRtcXOBwDUPfOCBLyHpP30EJwEFLlYHMjo8uJUR5?=
 =?us-ascii?Q?943o8raZ1olmJPIMQALovYHAqZtxlE94bG2FV6+4icK7obz6z0vAcHDqdS8H?=
 =?us-ascii?Q?th/wv/Fl20M/w4NveYVbaCUPExb3kRgFOwciMwtEmXJzPTP83b1CcpGV28lA?=
 =?us-ascii?Q?4pPmss7bqZbOFGbiTX+wEZHB3cYrR8nABPMb+c8LPj3VqAnTtinfJWJufVhk?=
 =?us-ascii?Q?E642AJ++3NrVc39gC4K6JaNXJHkkF9ftAzAN0WX0TmtBR82hAihh/G0ubqzU?=
 =?us-ascii?Q?HOfv3sJwqSNcq7l2BFWhvbkT0cI3Omb2oWocIDU1BDxMDnw+b48j6hIw2TM+?=
 =?us-ascii?Q?ngNVBlO22SH0L4/T+pjF7Cpv9GWHFJ88E5VzrTKoqQoyWQ3xWE+7zwR32tn4?=
 =?us-ascii?Q?R45cpwA1GzqxFK733Zk267fJK/0tUdKyQG5+HgdCD9p+YRTqao8lrwbppcgE?=
 =?us-ascii?Q?0iGG5LgGL5Vn0G7Q2pZNwZYX/0oUpTYHe8bqgO/22kXggG+sbHZo8Zdg+QTW?=
 =?us-ascii?Q?YW1sEGYg6BZQjS+pLCOGzh3/sOi30bX4HsoxcFESmlFPlYCNGaoDFpS4NH2+?=
 =?us-ascii?Q?Xf2zO6Q1cFjOr7LWhdIctUNPAgXidMi7sJaYdlw3vE94L0a53iz8XzL9+40y?=
 =?us-ascii?Q?P/QzwiJ65u7mTGe8WovsoKH+0gKHtE6ZryBWcfBW8P8C89eAiONZ5OFwbFlB?=
 =?us-ascii?Q?NZnmgbddfGY+9b4Wpm3jiATS4LrQtlQh2VtknIt3tYgwiY+IaUCWGthGAV1L?=
 =?us-ascii?Q?tMY2y7TvEOzNqcbXeEXhN8W0Petrl4hI8MoIzG0HVUCwrlrj+ccrKGvNkGFv?=
 =?us-ascii?Q?qKYWTmvXdVDH5B8IXnCOLFHm5vDPDnJvKLoIwAazMc1NdhWlyL0JxskNAJhr?=
 =?us-ascii?Q?SIxDFC2GNeVPD0y6DB2IUv/bF78NrQOwf5Hd9runywJNGdFqyIv7JUbW5Q6s?=
 =?us-ascii?Q?OBg686cldWXtu4HjU0IB+tfxduyRmA8Rfdwxc2+NSyYQjqvWvPS+x9+hkxdw?=
 =?us-ascii?Q?UsRYH3VVSKO3jS4eNZqli2mCnu2bo/5b2+5Lt1JjsuxZ0YM1OlunQ2P5wyG8?=
 =?us-ascii?Q?SahNy3UK5Qg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3uZ1B2qYCbT8mb/pcOhbEYmx0Fy24FoLPo6bYwS0ARg6G8FGajAc5YgpohmP?=
 =?us-ascii?Q?AyGcO6sm2gmWfluyQHke//5TB/AhMynX4Lur3iM3tgsF691pYZWosHx/vELr?=
 =?us-ascii?Q?jcZNFzP99BPSmX+YF+VFpBU13aUn1/Z5U16NfXFu6UjG9c+5awyjykuauL/g?=
 =?us-ascii?Q?SD2u3K6/K7bE9wt8QUZgbS18532JVaiQJsJLnlESFR2DrvKubsI8chDlgA/8?=
 =?us-ascii?Q?2FOIhHZp1X+iuMQWcZ0BXhpIavAR99U2X5CzKR8lXlkD4m0pvrT2gJp8LLr/?=
 =?us-ascii?Q?GjS8VZYLHFsGCt90cvaOmRiQhmNxtQcZ8Yqo2PaAHouyCqcXbXac3o9J28nO?=
 =?us-ascii?Q?nlUecywSM0vnyP70UU4iY2gWNXUYkoVGh2QhLMzUVAQWema8qzf687lew0kG?=
 =?us-ascii?Q?WIqNoid8WlFo3GviNJYxv3fWdh6iyNV+n0on0g1ZceSSayBij+hS+SDSDtgB?=
 =?us-ascii?Q?qmFSEVdKsn3WjsVqVxo+GcZZmPAWtzlqPyAoZcnHcdV2SpRr0JNWs6+Bl4td?=
 =?us-ascii?Q?UUbCDEBIgdnGAUZioP6J2nWQfsit9UQdjjKJZ1+44ZYUsPYPk7NQTyU9GOzy?=
 =?us-ascii?Q?Q5GEt16voSTCFE2vTdzkAK0qrNb4nCszv5hzFHaBwwuaNEy00MwreaM9kTPg?=
 =?us-ascii?Q?N1JpghA4KLZi/kXyl2uCufCd4ETRhpGRQD80e9+PIRCNb83ORENZFGZx/QJP?=
 =?us-ascii?Q?euyv3/z2MQhwo6y/d58/wu3wPAfQ7QOkWkoQtnMFdOPd41BJYJY0Mj640kZY?=
 =?us-ascii?Q?DNVlNOCRF+tcFC/GsjZvkTRn/I6P7+1MxjyNSzVTn9U61Z8Q6ax6M8HQk12Q?=
 =?us-ascii?Q?HQgdJLBDV9C9X93tzVahOXJ7ySPOGOqCnh1A7AndHk4hyyLRanz8LWJMl0Fx?=
 =?us-ascii?Q?IuAhkyTH0GeVfvhYIm1ngr1J6vsovhLPM2F4L1ON43NtAsnq18pEEI5oGF2k?=
 =?us-ascii?Q?80YboZIgF9fkQuWyEolhWlr6Vm2njA6kwIE39GItEPYvVUsafAG19YX4nosO?=
 =?us-ascii?Q?vg71TppqaA3pLQpSYQeRqUfM8fgY/coaLd/wyNkwMO3ULKG3cbmJN6C5WtHE?=
 =?us-ascii?Q?bgSvECkojHKPgKNtF7VhxwVevT8pzsWrD47l5CanGifuSMRYUqYzK8mxbyoO?=
 =?us-ascii?Q?H6pbSqyFSJbwDWOaTcq1LDLvPUpmnmP7MVKxPFziXcoiGS4JgrMq5mLkVhPf?=
 =?us-ascii?Q?/yS1DcxNMColy0FUr48k1ulzUADLoq498CPMXRid5q+D898dweXXqPsS5/Kv?=
 =?us-ascii?Q?NJFdzozYIXM0e4jJGkYNXRm5K8kDehzOxzmpUFEHGSpti+oY/0bisjNAZLRu?=
 =?us-ascii?Q?ZC4hVnbkW+J2yzXjPE1aG+BgvtvvV2YmCCEIA5F4if83GCXXNL3+TX4Qp1fz?=
 =?us-ascii?Q?bpp38wtCVHWVYSNA7QIRNfVQ1+EPlwJ3UPge0PNfgvlrEuPgSS5iYMysQzj4?=
 =?us-ascii?Q?vCq4zdTKoKNY85bRmWIa8QGPkTBlp4/5JkTvnPgzFMFyz/O3Tb34OSmWR7bL?=
 =?us-ascii?Q?l+dhveL7FXAsH/gGvV4KqrktzBSUDKIsxleulBzV/rMGCRzT/wqBqS3/ydp7?=
 =?us-ascii?Q?t6PNCqrbqSNkdhXnkZDUJtGiL5FroCMEh8d8rGin?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2193db4-addd-41a0-8ad5-08dd319fe003
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 17:54:48.5943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3yGWi+M2cygbi/Oo849GvhzGojsZKn2TF2Grwe64XT77qGobAcOP739iD0pzhZ1u2iPZGp1SKLiZvPegpg2zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5013
X-OriginatorOrg: intel.com

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec rev 3.1 section 8.2.9.2.1.1 Table 8-45, General Media Event
> Record has updated with following new fields and new types for Memory
> Event Type and Transaction Type fields.
> 1. Advanced Programmable Corrected Memory Error Threshold Event Flags
> 2. Corrected Memory Error Count at Event
> 3. Memory Event Sub-Type
> 
> The format of component identifier has changed (CXL spec 3.1 section
> 8.2.9.2.1 Table 8-44).
> 
> Update the general media event record and general media trace event for
> the above spec changes. The new fields are inserted in logical places.
> 
> Example trace log of cxl_general_media trace event,
> 
> cxl_general_media: memdev=mem0 host=0000:0f:00.0 serial=3 log=Fatal : \
> time=156831237413 uuid=fbcd0a77-c260-417f-85a9-088b1621eba6 len=128 \
> flags='0x1' handle=1 related_handle=0 maint_op_class=2 \
> maint_op_sub_class=4 : dpa=30d40 dpa_flags='' \
> descriptor='UNCORRECTABLE_EVENT|THRESHOLD_EVENT|POISON_LIST_OVERFLOW' \
> type='TE State Violation' sub_type='Media Link Command Training Error' \
> transaction_type='Host Inject Poison' channel=3 rank=33 device=5 \
> validity_flags='CHANNEL|RANK|DEVICE|COMPONENT|COMPONENT PLDM FORMAT' \
> comp_id=03 74 c5 08 9a 1a 0b fc d2 7e 2f 31 9b 3c 81 4d \
> comp_id_pldm_valid_flags='PLDM Entity ID | Resource ID' \
> pldm_entity_id=74 c5 08 9a 1a 0b pldm_resource_id=fc d2 7e 2f \
> hpa=ffffffffffffffff region= \
> region_uuid=00000000-0000-0000-0000-000000000000 \
> cme_threshold_ev_flags='Corrected Memory Errors in Multiple Media \
> Components|Exceeded Programmable Threshold' cme_count=120
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
