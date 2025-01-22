Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7132D1F7572
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737537268; cv=fail; b=BNy3QamysaPGVrXGE/PkkGTictdYCzVkSiGGu+UMpIgtOCnUU9+Pf7fHOCs1tpZhvvPWeRsEhnMVaOX4ITaZr0LEnu9FS5GyqUUlEs0Rz+RBVhj/gKEeLXDNY8qRknt2LQz5B1covXkXxOFMYCyIWQgNpBv9nTl5jDKH7thFUPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737537268; c=relaxed/simple;
	bh=NUT2g6vVcbOENShtPeR0jvHteYvU8TSj8VcR6GU+h84=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MAFYjvStQkjM0+z2wH+CaqK5WXNj4M1Hzc3sobtyfOjAjp0Yt6nXd9YUk926mlBobHwv7p3tcPhRX05p7uBziLfGL5W309oc+wFdKfTgyqVZw/nrnt31WDKPFydVP0x3/LIlHSnlApck0L01eLjkx/YnSwWOdvOlTg5YCCc8gEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4c2sOo1; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4c2sOo1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737537266; x=1769073266;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NUT2g6vVcbOENShtPeR0jvHteYvU8TSj8VcR6GU+h84=;
  b=L4c2sOo1XmXQt/sVgndn02X6DgpyIapIpza84JLyZCrYu/MKsuVBiW93
   BKZ09Y/UgEKV0K/vvkxjPdGsowugXuxrZPGnXIAlOXte3KxPbw3Wu3M5p
   UR2hqO0k8OgZioTn5Hv6AbTa/kNVMNsdRFVzJyGodld4Xib82OVknMe/p
   1gfj/jZiTB3aODakNyCm4K4la/2dNZFVhhm55OwSKNv6Sle4LawIh3ghb
   dEZXnj4BSdlOW4Q0bJiPTQEL8xJ9Yf6u4148SOki1kL7NHbzFjeZiF91f
   E3fQlvNoCMvwFJ9zPYMt8qLJSYicMbwU/1DPGo/IoMkG1Mw1zAK6KRtld
   g==;
X-CSE-ConnectionGUID: BTYzRkfKSUe9gx9gjqQZkg==
X-CSE-MsgGUID: 5DZgF11ATHWVp6CZ3/uWhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="38136733"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="38136733"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 01:14:25 -0800
X-CSE-ConnectionGUID: UGugTpEWQCqk47pvuVjuVQ==
X-CSE-MsgGUID: c7Gi5+w/SyC9uBW+EDOBNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="107004630"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 01:14:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 01:14:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 01:14:24 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 01:14:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6uxRbjKwkvxmdT4lRvzMJ1pGKz6i1qGBoM6jmPcF7OngZk912LEyJfZeOs8wdle7dy+tepGDOHHPxO58ttkKKXjmEo0lV/OhthOY+pyHKd5pgWeyNWcWUAeSqbdxwAfmHeo8uXxC+rC2cunuwXUY90N6g+GF86DuChQj/Sj2KuUrAWWXBXXerVrgvb8rpzW1PM5b9eP5uA2B3XEcvsoleJMDRFvQTNZYx5+9Tgz2TjZyWhpYWUdW539FhEDketgqPWY1jxXfNlIEPkH9Y2qUN5/+vNsIhkhtdzNIaTesULLnrXB745Ydm+RljDg9/jFLTaW0QoV3MtBDJ5JwHhQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioudKvTC8x1He8MenBy37FjNon+pUriphWyvMEOHH5Y=;
 b=X363Fffhd6gojt0oskaGNJEHlbt1AIG8LGouPNTnfbLXpdY5PGDm/ZPF99J9VWqhrTmgst4cBZosVhjGUwkA78v5KuomDMLq4NZIkric86tO/g6QaWjuMFSnPZx6UMcu4rKzPiK0qV/sGrMNIwuF3//vJlGzK0IrNU0wxUWHfdTXrsghBd3puCbvDt5Lq70B0zEe2mUOKTLgGbXk2tmUzBtk9AsruyLhHEHr1sSdZg24NZ2nEL8aP+BC4RNgKL7gVsiESs88MBbDIHdnFUFu4NP9IITKi3lf12GBwobDkMj3+q/VczLdhE9ynonKOIGwbRxlio3mSLXM4s/U4uIF+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by BL4PR11MB8821.namprd11.prod.outlook.com (2603:10b6:208:5a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 09:14:16 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%5]) with mapi id 15.20.8356.017; Wed, 22 Jan 2025
 09:14:16 +0000
Date: Wed, 22 Jan 2025 01:14:13 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Huaisheng Ye <huaisheng.ye@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>, <ming.li@zohomail.com>
CC: <pei.p.jia@intel.com>, <linux-cxl@vger.kernel.org>, Huaisheng Ye
	<huaisheng.ye@intel.com>
Subject: Re: [PATCH v5 1/1] cxl/core/regs: Refactor out functions to count
 regblocks of given type
Message-ID: <6790b6e5817bf_20fa2942c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250115152600.26482-1-huaisheng.ye@intel.com>
 <20250115152600.26482-2-huaisheng.ye@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250115152600.26482-2-huaisheng.ye@intel.com>
X-ClientProxiedBy: MW4PR04CA0141.namprd04.prod.outlook.com
 (2603:10b6:303:84::26) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|BL4PR11MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: e1640d41-02aa-43dc-79fb-08dd3ac52505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZfA7cQPpk0oVSuiP8a7oev4lacv1lyTNuHDzDpx1rkAItkDMo/5gNYsPSRDy?=
 =?us-ascii?Q?0uc1rlhXwrHnMfknPIKxHKxIhrCI0+UlRfftLHy0spqp3KznZgYjHcIPMRfS?=
 =?us-ascii?Q?iaBxG6Lyyjw2p042EnQn5xMCHMJUxlbE72fQ+S5g7pc7HsqVD1mZt/Et+JmQ?=
 =?us-ascii?Q?4hce5vuDdSxbu/eKgfPySAQL0UVV981A3TsMpfuDR+UyvGd50vHgt+uZ3xoP?=
 =?us-ascii?Q?1j4ZvWVThUahGCzbnu5Y1tn0C3NDs6fJbMj7oEGXNygMOcnuLRMXXcXO5e0g?=
 =?us-ascii?Q?nJkmyl3gMTtB9UlckJsxSNopb8gVAsUgS8oSRze8xQJxsKoUwUI0JA2dvKFq?=
 =?us-ascii?Q?utlrD0nQNNRJmLTnR7UnbKEgr7xwe1ddThCcQmmkEd994g7IWdVePYfBxKVZ?=
 =?us-ascii?Q?NZpSe8rcwwOpLooFeSU4FHclBnzWHTgX8nmWt+j5JJj9BsmD0Q+LuZTHP3Ey?=
 =?us-ascii?Q?4UFVmOQbxNGjzGnl3/c3kjZ4dL+OCsql2o0AnuZ3fCAIzd84PpRPuvx8qFAH?=
 =?us-ascii?Q?9YEgVApKFU9YcVsSoHj2VEQINf/LoYSX+Et3MfisxXPc9e4znghKY6fSA+WZ?=
 =?us-ascii?Q?KzaJ0mAMTk56rC2q00jFIWgyW2nYfvgEZdXwKGpI3Z1vsHU7YlrozWVxNID6?=
 =?us-ascii?Q?aqkQ/S1N019i2fee529xhQ3qTKfrwNoiOxnHguWX4szlVmn7lDu0nbkIMJCx?=
 =?us-ascii?Q?bMjijz+upW4VOwjm90Ql01NWdrM7UCLqlY9Yo+SPJqkJstjPqM/OzlzFNhZ+?=
 =?us-ascii?Q?kSt1gXhv9nIzeA/j4zoKklIFxTMIXabrKBrfWjW77zOjDrsCai+buuqTbeL5?=
 =?us-ascii?Q?pu90OjudjB1XiNnv8IyY9tRIQgXfgeAPOnZ+dwopSbJh3J8lL66Pmxw+Q9R1?=
 =?us-ascii?Q?uYmzGp2WPdpjVtb7K6A0IGTBQ51A9vUd0TBoQoM0O8rLOB10cLv4UMJ8Zm1l?=
 =?us-ascii?Q?0PQdDieABjaqLCSz/PRxOWmG3YQUwqL3xOOgtC4jJP257Xstiz8YGOBxK0FI?=
 =?us-ascii?Q?+mWyKuj2J9ZnABMftuFl8RiB4DZ0o0Ws2t3/0fKjdWz4yAO9B9TxMNQayN7R?=
 =?us-ascii?Q?bQ0UPzAgDue8b1x4DLkQClSzi4SMdvqoT+jRyGKzNR8c5eJrM5Q4IE3ePfNn?=
 =?us-ascii?Q?AnB/EY2vKe2/wSaEp7bP3ZqK1kU29n7JzL/2RUoHGmxiI9fbNWQqfYDgKtq8?=
 =?us-ascii?Q?61o68bVyKNJmsgVIFe64fmg6UXmcjsRThKOiA0nzGNgDRGRwozvbBIYGmVSP?=
 =?us-ascii?Q?l75kWVJXUTxtXpKDn8AUXeTtsySBFzBsxzN7W1FFuT/TPT+jowBWVjZUZxG0?=
 =?us-ascii?Q?7EDChjpeHNOvIS4b3Kfa+CLBn2Rdb86hIzGsYf4nfeDl9CL207/J74qIzsfH?=
 =?us-ascii?Q?eaB1tZc875EWZ3sgOUpOFdRd/7X+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/+q0qn4HWKBVQS+7G7eKFtx0FHaYo4u2d0Kpp0IhomyUyIGKqRXHkP1K5r4L?=
 =?us-ascii?Q?reDtLeIbzWYiZdNrbczLwRM5lr+rPw+UGi4VZzBX7vW85+mLsw/k66rSV1wE?=
 =?us-ascii?Q?GKrrn96g5sMGsusD03A5/q5l6Pucyq7j5RX3MfQcb3Esv4kuFo2EnOYNBg9u?=
 =?us-ascii?Q?ROhQlv9isQOrdkKGqzMiuoD3kZ8JznukIr2PKVDaoLKIIP11W+Zhn+4bed2Z?=
 =?us-ascii?Q?b5BEzuPLrZcWEnTon6SEdtdQg29t4DgvaqOn9K8Up1jGn4YFW9RCBt4u2gCu?=
 =?us-ascii?Q?tMIjt/zMNg5jRX0RSXni8Hf8u2Mfq9MV+ogH0HkS/zqkuSlhlirvG5xNXfn7?=
 =?us-ascii?Q?T0tCi2zeBHuv1Tk4OQIrpMHLR4pNo0Yv1M8DEp1mgjMo+1Decv4RLcWe/ty1?=
 =?us-ascii?Q?HZ+Et5Qb/UQiTMGIAhdoYFr3w2RwshPO3tEWvPNAtnbGeX1+QG4BlwEoQlj3?=
 =?us-ascii?Q?fQ4LwhdIWEeFP8LSkOlvWBRXq/ogDoPMtLOmlECBiWxmDHG11AhM2FU2z+Lk?=
 =?us-ascii?Q?SFOCJO5iRWSGWgxPpLo5Jm9nxOa8JJOdL/Dw20zTFWlLt9oc1OuePYhld2CV?=
 =?us-ascii?Q?U0alHe9AdDRYZG/9j+rA2r2rR1yG0l9jEtSVJBG/UfLo8S+3FTPLcu/evBhW?=
 =?us-ascii?Q?kYP8AsAOV09W1IUOQwB4iHNBO9P9efJ3Wp30LDswVTQOL4BWhZNCHBb4XWHW?=
 =?us-ascii?Q?VD+cNKYQslaJfzEa/t34lQB7VAWn5m8QBY5B662ZNgUFfoAe/29GheFgXRcm?=
 =?us-ascii?Q?fLCGESkJGwwtYrkrV+pWz4ux4fdUiHHN8OtgCVq9bPrmCCMVscbqrmAY+cf8?=
 =?us-ascii?Q?PPD4ebC5f4+UcLnhcOvfvCuaj3SOVawII9BFZ+rDKXVmTO4zPqd68aS/HfaP?=
 =?us-ascii?Q?mQgOLmnxaBrxB1DvfXIJYYh7d2djG9g8fwJSFSaXKIRRL9dlsdf0RzDSYkNk?=
 =?us-ascii?Q?BtXjiafLQtBSlLTmfL4Rs1ZUfMUM9s5leJ97xl/B8XRnm0emB1i2+AWZ2vhY?=
 =?us-ascii?Q?Gx1tpDxVgg8KSp3fXN6PxLzpo1KY4Lp2aNQ3g5GBozXv4aHhsOz3+XfvzECF?=
 =?us-ascii?Q?x4HU8sWLh5bGw3erz54C7PQm4TX7hJcOZVIz+XjvRpvzDK1tqBAWTakEqKo2?=
 =?us-ascii?Q?nEKBpR4AKuGhXIO1TIM9l/kzPNYzFzvZUapZik4l+gT+IZFgqZPfF6INtV5V?=
 =?us-ascii?Q?WDenbQAjdqZ9MmANQyet+amtQ+nZOmpNIisvtVXu1miC15tk82PPeMr8BV3T?=
 =?us-ascii?Q?iTjxUFOLb3F+ivRrqi0jd4S2BgBMOk1qeNj6xnbpQar3oO6RBuwFGUTozfIW?=
 =?us-ascii?Q?hpWT3qu/HyJhRLk04Qh/P9P1JlnRDZSE1UKXoaX2A7hoKXDM6bIHHRpS8FlT?=
 =?us-ascii?Q?9kkCDaX8xBml6K0peICEfPulWzYUxdm2asvRDibDRT4ZxkQxe+jlot0cDQJF?=
 =?us-ascii?Q?r55OepWLx/iIKKmuwGQtMBs0EXdncKCdMGxVzA2qyNqCHzP+3eCee2yKtCOk?=
 =?us-ascii?Q?wcyMkerjjRA/JKlfEJyIunjinBx+rjKD55uW/U0Kg2USZkTRMDtyvXUxVvzU?=
 =?us-ascii?Q?+eNpsavHalrjG7wMUQt/7TWihDxk/6MvHk5ahxzpJsxour4P/+57K6JJE3Ym?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1640d41-02aa-43dc-79fb-08dd3ac52505
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 09:14:16.1955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZkMHqZrGG83OEk5gNdm9lDqLyITW/ZrZk8qvwRMEy3chkjS4xKx2y/k/2oK8jeA012UUgR2zn2jrJ0n05/MGXyOUqsLQdAGZW0AXoyP0LA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8821
X-OriginatorOrg: intel.com

Some minor comments that Dave can fixup:

Huaisheng Ye wrote:
> In commit d717d7f3df18494baafd9595fb4bcb9c380d7389, cxl_count_regblock was

When referencing a commit the typical form is 

d717d7f3df18 ("cxl: Add functions to get an instance of / count regblocks of a given type")

...however in this case the commit history does not matter. Typically
commit history is useful for fixes to identify what kernels are
suspectible to the problem. In this case it is just a cleanup.

Also, for what this patch is I think the commit message can afford to be
more concise and just say:

---
cxl_find_regblock_instance() counts the number of instances of a register
block as a side effect of searching through all available register blocks.
cxl_count_regblock() throws away that work and recounts all the register
blocks by asking cxl_find_regblock_instance() to redo work it has
already done until it finally returns an error, that is needlessly wasteful.

Let cxl_count_regblock() leverage the counting that
cxl_find_regblock_instance() already does by passing in a sentinel value
(CXL_INSTANCES_COUNT) that triggers the count to be returned.
---

Otherwise, patch looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
