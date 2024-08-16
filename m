Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4103308A
	for <linux-cxl@vger.kernel.org>; Fri, 16 Aug 2024 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790566; cv=fail; b=AzXmFKZ5JdX+gk61w9QFW3ywSg8flTGeO8PKtzgENR3p3+5cAW9/2RnBva1yjsT+kTJKKibTdJS4zv7d2beNJdGRvDAjpTRWfgfvTfIGZLh+QntAgf8p1CbrcY8MbclBJD+TDpaQoRKSws25nI+bnVjeKKyMhw3Jyl4lqKNSre8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790566; c=relaxed/simple;
	bh=7nIt4dbeF4IJRQ17T+SXwR9UWrBLozETSSmxtUSIDbI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k+rO+r85lP5k+Rt0Cg6I1VH+kCwdYFG0buQPgUieYonAyD7Fu5neRFhYkdsieFowTv4Qd22ufXqgOvSldboWZFTKrMAYN3y5vr+D3XKhb3gqNMIJ8o3A8qRP1QP3dMfUemDcWDTUF79oahTTt+QwqhhqdS9yRr5OXxFUy9HMDdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NxlxKFDm; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NxlxKFDm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723790564; x=1755326564;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7nIt4dbeF4IJRQ17T+SXwR9UWrBLozETSSmxtUSIDbI=;
  b=NxlxKFDmt/fYTG8hn8o/keAPXzNbpuDGGPtcjyoIq216gkQdGinOb2NL
   yHcn4PDT/FMn7ELCQ8eMDOUdcEBdjsIzAPYiXwPegmEB/t9MoeEu/z93S
   AYXiKawZCveVOuNCmSLKiFzHF3HastuGifFx4zZ4j5MAIGXjMfremKYWS
   i6RGtUrdMlmKJCDG498jX1pGPoW3TMvUNHspI7esDZqkM5qLKAb25FLj/
   PtRLDvz14T3fv0mCJzJeKzsAFWnrsDQde/FC4RRabob70yjSlckCXIiO0
   FM3AViAcKO8IKdufnEN5qh5bStOXIO4M/yoxskpk+8dVnbpPBoF46j6oQ
   Q==;
X-CSE-ConnectionGUID: iCQh4C3ITpqDgOam8d01bg==
X-CSE-MsgGUID: srGFvWZ/THWU0Ty/ysJfrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="33489423"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="33489423"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 23:42:33 -0700
X-CSE-ConnectionGUID: Puj5sikLSzi8RTBQPsVhDA==
X-CSE-MsgGUID: hc8d/mnMTym1n3VO1aeSYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="64531289"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 23:42:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 23:42:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 23:42:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 23:42:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHHzf/pzaG1NEpFjt1zna6fQvhVrWJCjm6C71+5lNFyLEsMj4BwGyZDpg6hqwo0AyvL8c/ejKIapxidOm3Wu9csok8mfFIqAPF07Ejf1JYTbXaabrSoPW+8SSo0Ne2iq8kJqSArOH3rPtt70x8vxGl5xsIBCI1rcFfdv4bKYBZ8gHlcGXMMnAqHHxqCC89dF2gAodncIuHq6XzPf9tP6HKun/WRUImpPg7H2e1yIhEWZdmzqpvNGmfkCwmrqzKykBu3r1kx+OiX6ErTXxnpQsfMC+2414+Yz7X6mvLuh1RdmW+adRo+IF6oV2z+IPAnX6sqTLoz41rRaD4NHYn7qJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BnjbE/Y+Sn++Th8t3bce+w0MmyAkRsomyCl8WOdXNU=;
 b=jXW69Ht70msXox+69q9PTkrSrtvRzwAz4WhEnNPLd/iy58g8v2gOdI7JAXWgut+sdUSGuSnnBXtoALUwMr/rAj6HujuuowVhIzrNZ2mK7LwWd8XcyqXvZ+4BCKlAi45V08pNGJNsyN6AsyC8v17mNyu2Sbs0g8ik43RYl2fAN+MsE2CnT5nnbHGYJ9xiS9jmsaKLvW4SDCcsfCHUtt7vZdlAo4T4Si5CQFcwkFUhb/8SjVHSp0VcpvyR16lDSDP4IDsWAy/UBzd5+Z3TjtlRUwhkoE3K2wtA/R7eDQFeZxjJdGFTz2fYNYNNXvrK1rcHG5IbWZp9wayWZpSYlnB97w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by IA1PR11MB7245.namprd11.prod.outlook.com (2603:10b6:208:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 06:42:29 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7875.019; Fri, 16 Aug 2024
 06:42:29 +0000
Message-ID: <df04fddd-006d-4129-b684-2d0682f063fc@intel.com>
Date: Fri, 16 Aug 2024 14:42:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	<linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
CC: <y-goto@fujitsu.com>, <mj@ucw.cz>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
References: <20240815005510.220835-1-kobayashi.da-06@fujitsu.com>
 <20240815005510.220835-3-kobayashi.da-06@fujitsu.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240815005510.220835-3-kobayashi.da-06@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0121.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::25) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|IA1PR11MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: 8434b19c-56ff-45e6-9f72-08dcbdbe991b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dk03QlZKTUNsbHJKQVF1MFhPY1F4Nks0ZXc2d2VmSzd1UWtwMmdRUFdjVy9X?=
 =?utf-8?B?eW9WWXd3MEVyWE91YUplVGFhWGlReHFPS3M3NHgwUTNhdGorOWRwaXd5bXQ2?=
 =?utf-8?B?SFllQWRJYncrb3N1b0xxWTI5RzcrK0VmNjFuaHN5aGpFQitmWW40d2hWdWFS?=
 =?utf-8?B?aVR4cDc3Rktxd2I2OXpDSmEvQmQrN0JTcDVlY1JPRDQ2cW82TU90MTlWVkI4?=
 =?utf-8?B?Y0UrUjJJY3JZYkFReGF5Qks4QUVKUENXRFQvMHVoempFdGtpK1Bma1FXVUpz?=
 =?utf-8?B?OWlZeWtQZm9yK01lSzNTNGQ0a0tMemcrVU9BSEhCSm9YVzE5RFh3Q2x6cWg2?=
 =?utf-8?B?V20rOFFGRjVZQzltMm1Qd3B1QTBqSHBmdHJsaU04ZTFHNjFheVpwdnpXSjEy?=
 =?utf-8?B?WUtkVkhYOE5NU0EzSEtwRlo0b3N5bFFhVmQ3ckJDRWFkQkRrVDd2dW1QRzIr?=
 =?utf-8?B?em5CNG9XSUdKSnU5WUdOZFdtN0NyOUk0NEZseS8zRCs0YVZYUk5DejlZa3Q2?=
 =?utf-8?B?b2ZxbHFBWDA3Rm44VXlFczhVaWl6ZnBJMjBuTVVwY0xwdmVOL2lQSE9TMU4r?=
 =?utf-8?B?ayt1NGcrNjlOZm5qRFAwTWh4UzBaTEdlVHNLbmV6Um42cVVnZWZqRXFyOFEv?=
 =?utf-8?B?dmJJK2llbThpY280QzFyTEw0dDVjdGt3L3JLZnc1UTBNRHowYUdWSDRUZ1Q5?=
 =?utf-8?B?TzZGS1hQdS9oTEFoa1V1cmlPTUNMZkV4WE5mSk9RNmpwa1VuV3g1LzQwTmdG?=
 =?utf-8?B?SGttL2REdDB4dk1ML1l4R0tqK1ljaEVNWHhROFlUazZ1T3hNa1BPamZSNk9j?=
 =?utf-8?B?ZXRoUnhqTmFKVW54MzR2Mlc1bmpmT0lIZGJjVDFiRGliS01TM2tTMFJIRmtN?=
 =?utf-8?B?WndJM2FyWmpReTIxc3orYkt1bms0U1RDYXpNVzNRVkR3WGRmOUZCZk5YOEtW?=
 =?utf-8?B?cDNidE5MT1ExZTJBcm00SzBHMGIrT1Rrc0ZyNkoxUjJSOWVjRXdPY2owUG9n?=
 =?utf-8?B?N0RON0lpNVJxai9iWGpDZW5ZNVRnbDZiUzA5SU05NjdkaS9wdnJySmdldXJ5?=
 =?utf-8?B?S1VJaUpNV0xGQSsrVU0yMFJSUGMyMjBiaGRrY3VrbXcrdkdETGFHek1QS3dC?=
 =?utf-8?B?OGpRVG91QlRkWkhId2dxajNGeEd4eGRoWFBVVHJwRGJLU3p6VzJPNURtSjUx?=
 =?utf-8?B?YXdRVHU2djBuSWU3WHUyWVNGVlNGT0RLbm8wek05MW1jUnBwNERaTHVkVGdz?=
 =?utf-8?B?ZEczRWNOUjFBbjFNL2VjdzQvZThUOGh3cnF3TDlyRTJHaEZFUFNzR1VIYkJn?=
 =?utf-8?B?aGFnT3JVTVZCM3FpakdsclY5STlHa044bkg1MWI2Q1dKUy84RG5xeWRNNmkr?=
 =?utf-8?B?dERpMXZhYUZPck1LMDVHYnJ0QUlsRVIxeEdpK05EbWxNTzdraDFBdWQwa0FQ?=
 =?utf-8?B?L2N6R0hoaUozTlovcHplV1NNZ3lQTkZkZnBCWGxFZFZVNXQwdDZoREpldzg0?=
 =?utf-8?B?OFpBS01NUmF6Y2Nqb1Z1MEExeXF2WXIzTnVoMEhsQi9PVTVGK04xZytOOVNs?=
 =?utf-8?B?Rkx5SWlRMm1qY0ZiMzIxdHdyVjAyZUpXOWZWMmVNWnNHRTVDUTlZODh2bkVO?=
 =?utf-8?B?VWU4amlhQ0U1bFZFL3hsY1FjU1YxS0hXZDR3T1JYbk9yZ2JmeFpRTXRiZU1P?=
 =?utf-8?B?Tjd2RG9ERE94YmhhcisrZ3hLY2RTMkVtRXZzdzlEQ09kLzZtSFg1RllFL1V2?=
 =?utf-8?B?dDloZnJYd01SNlBCNnI2UmhVbThzT0pleG04ZkpoT3BGOFA4bzBueGdHNmkw?=
 =?utf-8?B?dmRpMkdlUEYwWDFiMzhMdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUVMc3MrdnZwSTRaQStjcnhHVm1Seit0cG9ST2xuTVhhT00wZVBoUjhVc2Rk?=
 =?utf-8?B?Qyt4bUVWNXNMbUNrZ2c4UU1CTjR5Wjg2NGRYcXl6cytLdlNzcSt5YjMrRDdW?=
 =?utf-8?B?ZXM3V0NnNXcyWG95ZlRvNHVWT29FRG9MYmFpcTkxRm8rMkxmaW5CdVUxc1BZ?=
 =?utf-8?B?TmN1QXN6TElBT1lDS1MzZEw2UG95ZDBrMGRHRkxsajlQdXJwT0I0U0owbHcz?=
 =?utf-8?B?YWRKWDFmbkp5Uy9YNW1QVmsxc0Zyak4raXRvbGttU0d5bERuSzM4V0ZUT1c4?=
 =?utf-8?B?ZlZsaG9aVVRad3FSRzNGYU5PbnowcHp6SWgvc0J2dnVlNi9wenE2aGtxazhl?=
 =?utf-8?B?bFBKb2ZUUXpPTG9RWlB5NW4yTDViS0xkYXBlZnFhTkdQbEhlS1haVHpSLzVV?=
 =?utf-8?B?UXE5UXp2emtiZWt2UnU0bnpYUU41eXgva2tXOVFzbWpCS0VFaHhyaGV3Z3hz?=
 =?utf-8?B?Y1BxK3BxUHp2U1U1QVdrbTYvMHYyRXp1a3FNejBQbjQvN1E0V0tHZi9NU2Q0?=
 =?utf-8?B?b2hoOVB0cGFJUGJrcWIrZ3RZQWEveVhQQk16YVdHWXRJSVBUZ2NDMmM0bU1D?=
 =?utf-8?B?MmNKdkVpQmxRV1hKMlYwNHFSVXB6YkhyOXA3TktOS0hvUzliaG4zL1o3cTBz?=
 =?utf-8?B?d2xjbEgrNWVnN0RQSXVFWmNKUkg3WDd6aFNVZ3hTNnNUdHovUEdHTk5qYWdi?=
 =?utf-8?B?Rm80R3k1KzB6SXJzQXNvbm1PRnZqRzNabFFRSW1CTUE2N2VsdURaYkhMd3RR?=
 =?utf-8?B?c01zWWk0LzFkazZMeEdJRVJlTXFiM2FvZ1dxVDMvYTVxS0VHUit4NkhTL0J0?=
 =?utf-8?B?MDAweitIeklLRllHdWE4NnNPaW5ERWVNU081ekJaeDNTakZGWStVKzVyeDlS?=
 =?utf-8?B?Q05UWk5nMTIwVGdwREZPb25PUkoyaW9HWXlsNi9vNTE4dnk0TFBucG1GdjIv?=
 =?utf-8?B?UUZKRkxCek9WT1BVSEVtUGVLYStZRkdSNXgxS0FYNUEyMThHSk43ckxoNUUw?=
 =?utf-8?B?a1VEdVZpRUJRV1RMbkhOZ2I2cldTbVNQUGhneUN1RU44WjZ5R21aZEJQVk5Q?=
 =?utf-8?B?ekV5ODBFbE9KMDRsbUFmblk2cnR1eEh5UmlJYlpOa2pkN1JpQVB2YW5YREF0?=
 =?utf-8?B?UXI4bnBOdUwxWGRmV09tOXFLNmxXZ3FLdWtZT2NqdEtjSkVJOVZsMXVjbjJN?=
 =?utf-8?B?aHJ2dDdyOE5tUDdYdjY3RzhiZ0RFUUVDdThCN0E0Q1V2S0t4YnFrZ2MyOFpo?=
 =?utf-8?B?K2RHakx0NG12Uk94VU1HcEN0enRrV0czUDhTUUNpYzh3M0NFUkloUFlFMGZ5?=
 =?utf-8?B?bXhtTi9UZVF5cTRVNmVZdGdQd0t1ek5HckhUeTdiTFU3S0x2U2pWTkRoaUVX?=
 =?utf-8?B?WHNvTFNQTmRXMHRnYTVLS093TGlVbjl4QWFIcmw2ZjVLd3NMTUJ6QVZURDJl?=
 =?utf-8?B?QnluTmo5WmJHd0JKcTFqZUFvbS94ZDd3eUV3VkNKeW9HQmcxYU5YeTgvOVMx?=
 =?utf-8?B?cVQ5TWVYei9TQlBtR2RpaUZiOEMraWZVTytHTlV2SVQ5N1k5RnFTaWFWZDVF?=
 =?utf-8?B?Vmp4ZjJDNkhLbzFQTUZheFAvMjZURzVZT1VWMEcvT3gxWU9FVUNZbXd3TUNm?=
 =?utf-8?B?N0ROYlRqSnNqYnM1Ym01amVnUGtqeW53MGxidWFtS0kzM1BUaG5BckhjMFZx?=
 =?utf-8?B?OHNSRjg4WWo5Y2IwVC9qM29pSzltNktBT2xibUkwN1cxVlVGbmRDVHZwMVpQ?=
 =?utf-8?B?cmdCQ0lZL1pPNG1OenA5UUI3NTlpV0RuYXRsYmh4d1JXT0kxR29QT0JvQWtB?=
 =?utf-8?B?eStUWWVkbng0ZlcyNUlCSk80YTB4djZMekszcUlZWFZSMkxsdmhVSVlwZ2ha?=
 =?utf-8?B?SCtzbjNXUlV2SENkV3dWYm1GQUo5UWN6YUpQZlVpbWZIazlXVHdka3hnU2FZ?=
 =?utf-8?B?OTVuWFNCbUNwZis2ZFFmSUF4T1Y3NFg2S1FtcVY4MnIwWVpXQlY5aVJ2eHNu?=
 =?utf-8?B?elVZZEw4RFlraVY4YWxZbWh0bjJndmxCblhMaTB4cklCZUZYMVlSS000ZWdI?=
 =?utf-8?B?aEluN1BlVVcxQWhFaWFpcWhxZjVqK0dWVHdiWkNrUnZzS0l0bUM0V2ZzR3pt?=
 =?utf-8?Q?1qw1vgcILHsIEIUR/Yna90A6v?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8434b19c-56ff-45e6-9f72-08dcbdbe991b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 06:42:29.2971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYBhHP3VCgG1zq6dFqukzrxuyqf3lbGAqBhweSt9/SuC4sF5rUcaNuIcZRzfwD3uGPGFtEcaeqxHCpj3VDvqtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7245
X-OriginatorOrg: intel.com

On 8/15/2024 8:55 AM, Kobayashi,Daisuke wrote:
> Add rcd_pcie_cap and its initialization to cache the offset of cxl1.1 
> device link status information. By caching it, avoid the walking 
> memory map area to find the offset when output the register value.
>
> Given that this solution involves port lookups via cxl_pci_find_port()
> and multiple exit paths where that reference needs to be dropped,
> introduce a new put_cxl_root() scope-based-free handler.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> ---
>  drivers/cxl/core/core.h |  5 ++++
>  drivers/cxl/core/regs.c | 56 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |  9 +++++++
>  drivers/cxl/pci.c       | 30 +++++++++++++---------
>  4 files changed, 88 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 3b64fb1b9ed0..95d94ec14eb6 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -75,6 +75,11 @@ resource_size_t __rcrb_to_component(struct device *dev,
>  				    enum cxl_rcrb which);
>  u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
>  
> +#define PCI_RCRB_CAP_LIST_ID_MASK	GENMASK(7, 0)
> +#define PCI_RCRB_CAP_HDR_ID_MASK	GENMASK(7, 0)
> +#define PCI_RCRB_CAP_HDR_NEXT_MASK	GENMASK(15, 8)
> +#define PCI_CAP_EXP_SIZEOF		0x3c
> +
>  extern struct rw_semaphore cxl_dpa_rwsem;
>  extern struct rw_semaphore cxl_region_rwsem;
>  
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 372786f80955..b1ab0d9bcbcb 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -505,6 +505,62 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
>  	return offset;
>  }
>  
> +static resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
> +{
> +	resource_size_t rcrb = dport->rcrb.base;
> +	void __iomem *addr;
> +	u32 cap_hdr;
> +	u16 offset;
> +
> +	if (!request_mem_region(rcrb, SZ_4K, "CXL RCRB"))
> +		return CXL_RESOURCE_NONE;
> +
> +	addr = ioremap(rcrb, SZ_4K);
> +	if (!addr) {
> +		dev_err(dev, "Failed to map region %pr\n", addr);
> +		release_mem_region(rcrb, SZ_4K);
> +		return CXL_RESOURCE_NONE;
> +	}
> +
> +	offset = FIELD_GET(PCI_RCRB_CAP_LIST_ID_MASK, readw(addr + PCI_CAPABILITY_LIST));
> +	cap_hdr = readl(addr + offset);
> +	while ((FIELD_GET(PCI_RCRB_CAP_HDR_ID_MASK, cap_hdr)) != PCI_CAP_ID_EXP) {
> +		offset = FIELD_GET(PCI_RCRB_CAP_HDR_NEXT_MASK, cap_hdr);
> +		if (offset == 0 || offset > SZ_4K) {
> +			offset = 0;
> +			break;
> +		}
> +		cap_hdr = readl(addr + offset);
> +	}
> +
> +	iounmap(addr);
> +	release_mem_region(rcrb, SZ_4K);
> +	if (!offset)
> +		return CXL_RESOURCE_NONE;
> +
> +	return offset;
> +}
> +
> +int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport)
> +{
> +	void __iomem *dport_pcie_cap = NULL;
> +	resource_size_t pos;
> +	struct cxl_rcrb_info *ri;
> +
> +	ri = &dport->rcrb;
> +	pos = cxl_rcrb_to_linkcap(&pdev->dev, dport);
> +	if (pos == CXL_RESOURCE_NONE)
> +		return -ENXIO;
> +
> +	dport_pcie_cap = devm_cxl_iomap_block(&pdev->dev,
> +					      ri->base + pos,
> +					      PCI_CAP_EXP_SIZEOF);
> +	dport->regs.rcd_pcie_cap = dport_pcie_cap;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dport_map_rcd_linkcap, CXL);
> +
>  resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri,
>  				    enum cxl_rcrb which)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 003feebab79b..839c5a20cc33 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -230,6 +230,14 @@ struct cxl_regs {
>  	struct_group_tagged(cxl_rch_regs, rch_regs,
>  		void __iomem *dport_aer;
>  	);
> +
> +	/*
> +	 * RCD upstream port specific PCIe cap register
> +	 * @pcie_cap: CXL 3.0 8.2.1.2 RCD Upstream Port RCRB
> +	 */
> +	struct_group_tagged(cxl_rcd_regs, rcd_regs,
> +		void __iomem *rcd_pcie_cap;
> +	);
>  };
>  
>  struct cxl_reg_map {
> @@ -299,6 +307,7 @@ int cxl_setup_regs(struct cxl_register_map *map);
>  struct cxl_dport;
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport);
> +int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>  
>  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
>  #define CXL_TARGET_STRLEN 20
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2ff361e756d6..4eaf64d92541 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -471,10 +471,9 @@ static bool is_cxl_restricted(struct pci_dev *pdev)
>  }
>  
>  static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> -				  struct cxl_register_map *map)
> +				  struct cxl_register_map *map,
> +				  struct cxl_dport *dport)
>  {
> -	struct cxl_port *port;
> -	struct cxl_dport *dport;
>  	resource_size_t component_reg_phys;
>  
>  	*map = (struct cxl_register_map) {
> @@ -482,14 +481,8 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>  		.resource = CXL_RESOURCE_NONE,
>  	};
>  
> -	port = cxl_pci_find_port(pdev, &dport);
> -	if (!port)
> -		return -EPROBE_DEFER;
> -
>  	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
>  
> -	put_device(&port->dev);
> -
>  	if (component_reg_phys == CXL_RESOURCE_NONE)
>  		return -ENXIO;
>  
> @@ -503,6 +496,7 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>  static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  			      struct cxl_register_map *map)
>  {
> +	struct cxl_dport *dport;
>  	int rc;
>  
>  	rc = cxl_find_regblock(pdev, type, map);
> @@ -512,11 +506,23 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	 * is an RCH and try to extract the Component Registers from
>  	 * an RCRB.
>  	 */
> -	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
> -		rc = cxl_rcrb_get_comp_regs(pdev, map);
> +	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
struct cxl_dport *dport is only used in this case, it is better to move 'struct cxl_dport *dport' definition into this 'if' scope.
> +		struct cxl_port *port __free(put_cxl_root) =
> +			cxl_pci_find_port(pdev, &dport);
> +		if (!port)
> +			return -EPROBE_DEFER;
>  
> -	if (rc)
> +		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
> +		if (rc)
> +			return rc;
> +
> +		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
> +		if (rc)
> +			return rc;
> +
> +	} else if (rc) {
>  		return rc;
> +	}
>  
>  	return cxl_setup_regs(map);
>  }


