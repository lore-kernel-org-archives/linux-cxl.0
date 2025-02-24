Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC42DB674;
	Mon, 24 Feb 2025 18:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421797; cv=fail; b=ODTaF6trxWw7fINer3+Q1a4savhVRIVLbmOFSIDioAU8W7LwUCQjiMT7HfcXAlGvAfQqCcid3zeI8Iv5rzJh3j8TnVKKW3jSmtQOF7FF1yov/iDJaMAw5rPrgDHh4nrVsD7SwL6ovRiqV+bSbbLOYIm3JJ6VyvOnnWbBgA8FIvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421797; c=relaxed/simple;
	bh=xs3C6v66z4q6RVYIlCRuXhh2tWnryPuZp82DLnu1hOc=;
	h=From:Date:Subject:Content-Type:Message-ID:To:CC:MIME-Version; b=kljFJSiwc5boeYo/n5QHrmOs7xXetN/6W/iFbWoUhSlmtXVyKFzmW2k5sGW9X18bcrHxKxMewmOujKm5ph/EUkcGjNicV5Fu3zYSC/RRWyx8LY1xUixihRaqtu5eexHBlnxFf3DeOMfC3c28XQUdUaNJMIye8EIzalR4WlCGMI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9A4TFvN; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9A4TFvN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740421796; x=1771957796;
  h=from:date:subject:content-transfer-encoding:message-id:
   to:cc:mime-version;
  bh=xs3C6v66z4q6RVYIlCRuXhh2tWnryPuZp82DLnu1hOc=;
  b=D9A4TFvN6u0469AMzWjfwmzoM35X8OJrV30rVJgpaDX9SRXMxb/sy5qS
   jxMwGZChXpYpeEjZaGntJNK3ZIEkOpjpUih9APRWjaD71hgUf7MTH/aP/
   D9dxwwf6jmN4D+lHJYkcxQVFffVYcKXG4ezdC/S8SvCTOgAoWq05yOTZH
   3OXjLtS6UTdyWSGkrpmFTYovqFePL+pL83KAqnkabrTMAdQDXyJDnj//s
   L/bKp07GjR72SJfvJOOOwJPbQH44HtRtrHb0A+sxS4jjcXXfhV+HOix2T
   THfaYEGMSRQhxT2p6vJWMHtaVlqW1QXSyQiFiSgjd+K4TLRq0jY8q7uCZ
   g==;
X-CSE-ConnectionGUID: yyiEv4z5TCOFkI2Gqd07Lg==
X-CSE-MsgGUID: WQ8q4geDSkab9cD6AlKlRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40431371"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="40431371"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 10:29:55 -0800
X-CSE-ConnectionGUID: /NI/o7qVRfqWLvE0WDNcUA==
X-CSE-MsgGUID: vm2akRbuQf6bWLt9gI0FFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121392298"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Feb 2025 10:29:55 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 24 Feb 2025 10:29:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 10:29:54 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 10:29:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPdwrXizZXj/SDJpQ9q61obV+Vu3c6MpC4DcdIOItGzHH2oX7zLXylt17DfXvwnl7krI92Vrm7DxPdxqBnekBLRSDfbLGyat5ziPcPgTmBKBLO56Ye+MeBxxjVG89HdnbRqyLCdMfqs9S07k9b0bSZ8JhzF1q8T030w2QoPdrV13bADwa9cV+UCgfADXdvdR842Q7FBnla2RSYhUkb1Jfan/ocicvg7wqhUKmWMB7PfK8KkYqgCEXg3cMMwB19/cm1fcP9VjMpsojwbfwVP3AsY3WoXvRtRFovVWqdNsVR9KQ266E1cWAkAVkVxD44jRaiytlDx70Ywu3O8THIdetw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lh648gH9ynoPgz/tGh4PB76wXDI6xFpgciLeOoBtJEM=;
 b=Pb4ux2KFpFTqAjQC+BWyT3v7tYuVfAagd5mmNkfN6OaM2WqnIqeDNAyJnosb3n84wpSbLq3qA7Z6LoJAdCeOkFHphcQCW70vPCU+TZCIWYouBKb3bo7VDqOIC7aNvCEWBZP876eivV2oFlZ/AYuDEN5dOzhJ/I9GpRk1XvrbjuE+OY4WXggKemtwvN352axFNf8V3Fj1PtR99ydzbURKXzNGHsSTy/36fc8tlTQsHm7UlDrWoTA6G8k6J6YCgx9tjWnc4MNr3HFgAy7ixCjZejMo0rbTa2n6ieTnz30d5VlZeVWSd0RC6MltuCBIC3Ujv6pe0OK/sbjiTq3stFcQOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA2PR11MB4828.namprd11.prod.outlook.com (2603:10b6:806:110::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 18:29:45 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 18:29:45 +0000
From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 24 Feb 2025 12:29:29 -0600
Subject: [PATCH] cxl/Documentation: Remove 'mixed' from sysfs mode doc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250224-remove-mixed-sysfs-v1-1-a329db313dac@intel.com>
X-B4-Tracking: v=1; b=H4sIAIi6vGcC/xWMSwqAMBDFriKzdqBWreBVxEWtT52FHzoginh36
 zKE5CFFFCi12UMRp6jsW4IizygsfpvBMiYma2xtrK04Yt1P8CoXRtZbJ2WUg/eNK9wQAqXwiJi
 S/qdd/74f/a7AzGQAAAA=
X-Change-ID: 20250224-remove-mixed-sysfs-e3baa7616bcc
To: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
	Ira Weiny <ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740421789; l=2078;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=xs3C6v66z4q6RVYIlCRuXhh2tWnryPuZp82DLnu1hOc=;
 b=7CDW5ePisSOe0PnqQ8Lnk2+q8b4DAGXryePrNRsFlL12yDqRopPyEFwaoqBYp55Q/hOH7vm68
 qBDf3mTtsWJAxgJTBSkFp/vWJ9cBZTvDS/pxqfif6nZliCcq3ZRx73O
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-ClientProxiedBy: MW4P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA2PR11MB4828:EE_
X-MS-Office365-Filtering-Correlation-Id: dbf5feee-6700-4757-2a80-08dd5501364e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cm15aXhrRTBzMDJyUWxMK0pLRWZMaCswME1lUlM5WEZ3TXFqcTA1U2JzVEZ1?=
 =?utf-8?B?ckYxK3hsTXJmbzZzUmdXSVdySnA0aTdTSG9QUE55Wks0eWNRc2E1UVI2MnI1?=
 =?utf-8?B?c3ZOYU85THZVUjliZWhhRm9BNCtnTDRzbUNYY2hYTmtVQ1B3SkpHUmNYUHRS?=
 =?utf-8?B?bmIxWlphZ0l5N1NlUFdlTkNwbnZnaS9XT1F0ZEJFUWRRK2xlcllmZE0rY2Nw?=
 =?utf-8?B?VzRmR1k0TWtNbHdVYW1UYW5iM0RwL0N6dFgwbC85eTBZWjZQTm9Ha29WSytp?=
 =?utf-8?B?MEhpWGs2Z09ORVF3RnlSWjkzODA2QnRydFZzMGI4UkduM3ptY2ExNnZXeFNp?=
 =?utf-8?B?VWk5UW9LdjRSZU1ORUhWMTI0SU9SWDl6MklENVF0NC95Z3I3bUlnbTluLzBt?=
 =?utf-8?B?elR3NnlKMGpBZFVMZmlob2lOUWxCOXlZV0FrRlZjNm1NMThyaTh5c2FYTmFu?=
 =?utf-8?B?ams3WVVnUWV6cnhxbnFIdGlsSVhaMVFjWm5tSXFHcitQQ3lVUDBLUklXMkpM?=
 =?utf-8?B?WTNLMy84RkM0QmwvV0V6MmU0WXpMRVRSRUE1eCtxNE9PNitjR1IvV3h1VkNz?=
 =?utf-8?B?SHZrQVVtVEp2SitaVnFJbFhWdFNVdVJKVjlYdFUvTGhDd2FpL3RIRVc0L1RR?=
 =?utf-8?B?Vk4ybDVhWE1kRzZKY2tXbE51SzIxK0h2NlhOeWxoRkVjaUdaN1gvNGFDNGw2?=
 =?utf-8?B?aENDRkRXdG9DdTA1eWYzWUFrNjMrQUNsRHBuMHVwMmRwVCtVU0xJY2pwUm9M?=
 =?utf-8?B?V25yVUFwcUZsKzJmVGpQMW11Y2ZCZkZsWDdQSFpOYnpWNmN5UTRRVzZqY2hj?=
 =?utf-8?B?TXVYc0JPejI3Tk4xK0lJdVpkcWVCRm1pbHNIRHFpdmZNNFp1K2xzWkJnOFdt?=
 =?utf-8?B?b3FoVVpYMmFNcjQ2Ti9pTEYyeEVoZU5SN0pRKzBPMHAvUEIrdUtHZHpDOWVQ?=
 =?utf-8?B?MVR3N0xFL1dKdE1yZ080N1BIdU9jSWE4WC9PWEFSdWU5c2tNVFZOZ2NDcCsr?=
 =?utf-8?B?WWtFbUlMc215L3dSNTRETldsNzFtbkdtNG5pVCt5ZjFsT1prRjh2anZUOUQ0?=
 =?utf-8?B?SzRhdHkyRU4rOExMN1E0OGxESjVmU3JtREhSbktHR1JNYWhjRzRIYlJZNU8z?=
 =?utf-8?B?UVV0bkZaUDJQaGxTU2xPVWdMUXFONHJyVnVJbFpiYWVoRHBTM1JNNmNwa2lv?=
 =?utf-8?B?dXNrTm54WW80Z3lBZEJkdnB2KzlVb2ZwTGhjckdTeUxSV1VIY0FnL0ZsaHNi?=
 =?utf-8?B?K0lMTGVtdGV1NXdsVzZFTHU0VkdNcll2V25pbVovRjBjQVNJUS95U0x4QTEy?=
 =?utf-8?B?Q2NXVVpHTDJnT3RCQ1pWNGZXeG0yQzAxaGhxMnFnSXdjZGZ0MkYxRzhYdVVs?=
 =?utf-8?B?MnRGNTNUKzE1eTcxbVM3UWozZ1lhQThTVmhxWXpiK0x0UGRyVCsxR0RtSGlK?=
 =?utf-8?B?bk1TUmxmN012NkNGNFZ5ZkNqSXBkYzNVQTRKU0NoMTJhR2dEK2NkdTd3anJq?=
 =?utf-8?B?b2NSZXlIc0tKZHF0ZDFvdlhxZjdUc0EyVVJLUm15TlBEbGNBdjJPa1VVRWZY?=
 =?utf-8?B?MThRcnpsQUhMRUhsYlBoOURLam9OeDZ3aVlLVzJxMkdrNTQraDBRdnlpWlZj?=
 =?utf-8?B?dmZ6Yi80a3EwcU9zQlNsM3RCTWZObW4rTXlaai8rMmpscDhpUWZqbWRLQlhI?=
 =?utf-8?B?RG1DVXhmMVZUWmtJVUt4alpsTWFVT01rN3k4bWlzTUlYcFpqRDhDWFZHdkpm?=
 =?utf-8?B?RlFGTXRTVUYveGtTOGNyZFFYL0xleUx0clRZS0JXME9UUDdFbWp0dHRCRTZT?=
 =?utf-8?B?eFNWY1pycDRPTzVKMkFWRm9OcGdCdHhRT1hTcXVEcnUwOE5BTTd4YkprWFVh?=
 =?utf-8?Q?uZ+CkKXsU/0Tl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3RjOEs2WVBwYngvNzNoNXl0L1M0dWRoazVlYTRmL2Vmb0hyd2FUZjBRL0p2?=
 =?utf-8?B?aFhmVWlab1B0ZVhBUWs4a3pyejlJRVRkWlZ4eEJZOEtkRUUzMnhLUlZaaTgz?=
 =?utf-8?B?NXRtUEx1SHhyT3YrU0N4ME5qMUtFcEYrWU9CSXpZZTdWejJLVGNiNTd1d1Fl?=
 =?utf-8?B?YzRDM1R4WmpRRzBTU1RhY01aVG1saitXNll6c29LbldhWTZ6RGV0WGd5Rnpv?=
 =?utf-8?B?QmxCMWYzcFhPMmRoNEJaTVhYSXQ3aGpMaHFIc3BGZUlEY01ZZVZjRnd0RlQv?=
 =?utf-8?B?UzZYalRKVDNkaEYyb0gwR3BhK2Y2dTFkZlJKcEZuSnAyQUJha2R0dW9DUzM1?=
 =?utf-8?B?Mm1PVndGeVdTdDMvOVdPVitpMmY0Rm1Bb1JaYjhhQUl1ZDVDM09jTG1aTkNI?=
 =?utf-8?B?T3hOYmZyWDlsRHd5eGlueXdyRXlqSjZyYlNFbjhpcThpRlVsbEYvYXBrQnZU?=
 =?utf-8?B?SytDMUhHbkFNc0dmZTI1ZVhBazR6alV0cVA3aG1nclg4enRKUlBTd3hiNXox?=
 =?utf-8?B?K0VoWFFyR2ZXT3pwNWpwNTA3elBFNFNGeVpXaFMxaVFCSG42REYweHUyTlZV?=
 =?utf-8?B?c2Z3bXVZYmxVUXlQckJTTGFqMXpZN01wcE0zTlVVS0RqSzVZU3FMTzYvdDND?=
 =?utf-8?B?VEtoMklOekI1d2piM21XQ0R6RWRVN0sxbzZPa3JSVmxoSUp4MkZyTDlhd2pj?=
 =?utf-8?B?eVNXeFJvb0xzVjh2MXJYc1JyN3dCRCsxL2doOUN4YkF1VzE0bzE3MmFzMzA0?=
 =?utf-8?B?cGtQQjI0MFYxcnFtS0JNNVRJUnQ2aE4wcExXaThKbDdmbFRieUU3Q3N1Q2F6?=
 =?utf-8?B?bWk1T3d4a1RtQVhRR3RPWDdtelVsR3lML2pSRi9KTVM5dDc4cXZqTU50Q3du?=
 =?utf-8?B?eXhFa1VHR1RJcGxsNTNFSXhhZlMyRFp5a1ZHOGNEN0FaY3lnaWZtSDlZN2Nv?=
 =?utf-8?B?VlltdHJqSFBZUm16THl2R0lZcFNDWFFFdHNQRUptbzRXZWpKbDNqREFtRGpT?=
 =?utf-8?B?VHZLbi9ld01ZRk4xaWhPMUM5blNwT29kL0RJOVBKNThtMklEUDZEdzhHYWgw?=
 =?utf-8?B?L3FvRy94Z2dVanFlWW4xMFlmQWphK3dJZktXZnY0WUM2R3JPNU54OWFlZWZo?=
 =?utf-8?B?TEdhN0ZpQ2hZblg2dnRxZzdmRmZ5YTl0bldzdXJaUXNMQXUzT2RxQ0tOUmNk?=
 =?utf-8?B?b3BYQ0x5bVlxeWlWdHJ1MkM0T05uMVN5emg5TFpmR1NJOXBMenQvckJKa1ZM?=
 =?utf-8?B?YVRtTFJ2bUs1VDBEcG5EL2tQTHFibW00SUVJejNwd2NoODdrWm5ZWG94bnZP?=
 =?utf-8?B?QkdrcEx4NTVZdlBaUlFKRUZoQ2VGME1DS0lNaDZMSG9UTUdYcERrSVprRnk2?=
 =?utf-8?B?aitINWtqbjRVb242WjJLdkxicTdud1JiNkxsNTFXRllsNHBZWCtVNVdMbVZp?=
 =?utf-8?B?aXlPeXREYmVCZHArZGoxREcrNi85QzFpTUFtVi9kL2hwTi9Ib0lnU3F6aXpp?=
 =?utf-8?B?NFR5bTJHY09SOWszRS9jQVFpMmoxR2JINVR1K3ZiRUxDenozU1IwMndtOW1h?=
 =?utf-8?B?MVZyMXVaNnliSzlYQmxVUlFNLzZtNlFFTmRUb0RYb0VhcjNZR3B5Q0J3ZThq?=
 =?utf-8?B?b253V3gxdE9xcGpsZEpNVEdLTnoyWXE4c2QyMG5kZUpkbWFBckxzSlEzVWlt?=
 =?utf-8?B?UldKQjlVd0x1SjdYTFdFTW9JUzFrZGJhdzg0czRoc2Z3Ri9HZkNGRk5JNW5H?=
 =?utf-8?B?anFVSlR5QzFINHJFa015YmxmQTRQajM1RFMrenRMOXpLcGx5dlQzdFNkVDdq?=
 =?utf-8?B?bWdjaDdFMTVaVHpIN2NyOU9tV3RIREhrMTIxWFpzNDdURzgrdXBPMXFTd3pL?=
 =?utf-8?B?QTJaYzB6citUKzk2OWRCNFVYZk5tNmN6TjFuM0R4QnRNOHdiTXcxTXdob2pP?=
 =?utf-8?B?TzNOSHpmNUJsVzdrMWVPcnBTWjl6UW1pUHhhMXY5VGEybnVmbVlTNnJJQnVr?=
 =?utf-8?B?RFRrSE5HRUFnY1JzUXg4SkNWcmxsUXVVbXhBeFdnbUtvMTVZYmdENmtqcGl3?=
 =?utf-8?B?V1VWbGNHV3ZOcE5LaHJTRXFxVHBQZUw2YWVLUUMvWDNteXhaM2dFMlBzcWg1?=
 =?utf-8?Q?rQaQS6f3sdckRbCBoo+JzYORy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf5feee-6700-4757-2a80-08dd5501364e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 18:29:45.2913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEoP+QWFHtMscI051Ml8JntJ4DoqODgVYnCtix1G2WujULjuCFvo7FfLcXCcwuFOTWLzO73ulcEyWL8SCxk2JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4828
X-OriginatorOrg: intel.com

Commit 188e9529a606 ("cxl: Remove the CXL_DECODER_MIXED mistake")
removed the mixed mode.

Remove it from the sysfs documentation.

Fixes: 188e9529a606 ("cxl: Remove the CXL_DECODER_MIXED mistake")
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 3f5627a1210a16aca7c18d17131a56491048a0c2..3ba551ed10e29f33b9eb873bab9b542c8afb66f0 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -321,14 +321,13 @@ KernelVersion:	v6.0
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
-		translates from a host physical address range, to a device local
-		address range. Device-local address ranges are further split
-		into a 'ram' (volatile memory) range and 'pmem' (persistent
-		memory) range. The 'mode' attribute emits one of 'ram', 'pmem',
-		'mixed', or 'none'. The 'mixed' indication is for error cases
-		when a decoder straddles the volatile/persistent partition
-		boundary, and 'none' indicates the decoder is not actively
-		decoding, or no DPA allocation policy has been set.
+		translates from a host physical address range, to a device
+		local address range. Device-local address ranges are further
+		split into a 'ram' (volatile memory) range and 'pmem'
+		(persistent memory) range. The 'mode' attribute emits one of
+		'ram', 'pmem', or 'none'. The 'none' indicates the decoder is
+		not actively decoding, or no DPA allocation policy has been
+		set.
 
 		'mode' can be written, when the decoder is in the 'disabled'
 		state, with either 'ram' or 'pmem' to set the boundaries for the

---
base-commit: 8760c1c0bf7eee63a56b5f9edb42d93737a6a378
change-id: 20250224-remove-mixed-sysfs-e3baa7616bcc

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

