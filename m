Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA9513D539;
	Fri,  4 Apr 2025 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743787401; cv=fail; b=qx7+hUp0dADQuzVUqC9ciFbsO4O8+n8NftSC5fx4qiFhwUVMeNYc2iqDNY37BxoK0MjzsvfKJcnPXTKVkLaoILi0fb9gzB090Q8Z+f27rKHrl5f4ZQcsTBHnoaYA5CC+omg4MogMVTvs5MXMukxOei0a7fk5SWpgXqe262DKywo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743787401; c=relaxed/simple;
	bh=Ghpiy6LO7JOc6m90yKobzZAyOpm74QsvdY1zIrVqQdU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R8HMVh1Q5Zrcu87f9DxiSVMQACPkHYF6nWj8uyBl4rA69JWPtDux030xtsVnRAu18Lj4emV7EEnDF+7xsSF3BsdTe6sz6cppyJt+Yy9sAz5LnZQZhyOABidkYCHPLcZhmetbicMZ1sDwB6znHI2V/cQZlw9mQhD4Jd5L1OJM4mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDVsm1F0; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDVsm1F0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743787399; x=1775323399;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ghpiy6LO7JOc6m90yKobzZAyOpm74QsvdY1zIrVqQdU=;
  b=mDVsm1F0NjeJAA+0MopVjg6/2FIVJVIMeUatLbBosIA/hz7fvi53rUdH
   vIvetcR/Uq3xd87Y/L6/fmBZoUQ8cRvwj7/DeE96+o36LX38X3oDl+GUO
   cr8zoVqo9kaYvgXX8I6Gih5Svn1OW0CM9O81CzV+hp3nUB224l9qyB7md
   DtwtiYG6zhn7SjRcLjf02HtGcTkmGAut87LvvE2C15dVjRq01Rh29QNfk
   nurBLjwnlMbwDPbCpZS7LW/CtzPj0eyk+Jm/grxyhZofdSq7Tj6jPphQM
   3q1HXzFzkMLpp9JAHWPDQci1pPz3nTH1HcekeueYWvwnQKCM6SZ9xPgLk
   A==;
X-CSE-ConnectionGUID: nIu5RvC9TVaeMDUjmj8zoQ==
X-CSE-MsgGUID: Ajbc9hLSSemzKhKSdztyzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="45251323"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="45251323"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 10:23:18 -0700
X-CSE-ConnectionGUID: wmSwTsqxTaGVf3Ne5HBYnA==
X-CSE-MsgGUID: ZFNTKdnLT6iHKSvz7nnWyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="127307818"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 10:23:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Apr 2025 10:23:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 4 Apr 2025 10:23:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 4 Apr 2025 10:23:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqqnovJj8Cwjg+3Sv7jjj6aVYgvefCVW7IENgwCQYfRKvVojNTFSSI7QN8koD9f7TlqViQs6EUbS13sXg1X/0nHUy0QpuH1AGXbepOnRoNRQdP/Amn1fCnXIKcYIjZeuLKot7uvYSp+UPbxwqO2FhP/dtDaqE8aQwAhfN3WTNdX+7Y6eg3fEp74Cg4tSY7n21hb+rguUNPwY1FgKuWKSXAVFvCknuo1pBeg94iFpXqqv73ovp0mE3N2Fi2ph5H7uwgGhrR3uYsaqi1ucyaJlpZykZa9RDuOsnr7Se2HBFeHG2h5JLhsjBQxmxdlwyYk5mBdUr563eRcyU9Ho/42Dvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YqIvLrkzBTaP8N6LdiJR0f3dM28O1/c2ciL7L1sxKE=;
 b=IkTN2fxwcWzNrphO4pWX7BQSSqOQiXmNfAyFbe+ZoG+yeGrFsuEN9lFCOWDpfkULZawU4YV6EkMZ7hCo71ifRGS18A5SiuPRkewga6sq5ZzPPCej5VaBXbb8ICS19cKQdnDNQ47h+1bF1K3jkTGTa6hJWekpR3zf2cPAiqFdIX+DGRGdDGLpwbr/qjEF+ZAecHkNKa6ZTisLmZv8ZiZ4Sxtcu4m09GXil4tOslCFo1CdM0dVc0mOUqZmqbcWjdEQoh/LpP70rmjdOlhP/PebXmVkcTzXczYkNOcxhK8ITrL8w6SHNbRGptjJKr/9i8al+OyHJsvweAZUO74qp5l4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7310.namprd11.prod.outlook.com (2603:10b6:8:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Fri, 4 Apr
 2025 17:23:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8583.041; Fri, 4 Apr 2025
 17:23:13 +0000
Date: Fri, 4 Apr 2025 10:23:10 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rakie Kim
	<rakie.kim@sk.com>
CC: <akpm@linux-foundation.org>, <gourry@gourry.net>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<joshua.hahnjy@gmail.com>, <dan.j.williams@intel.com>,
	<ying.huang@linux.alibaba.com>, <david@redhat.com>, <osalvador@suse.de>,
	<kernel_team@skhynix.com>, <honggyu.kim@sk.com>, <yunjeong.mun@sk.com>
Subject: Re: [PATCH v6 2/3] mm/mempolicy: Prepare weighted interleave sysfs
 for memory hotplug
Message-ID: <67f0157e498c9_464ec294df@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250404074623.1179-1-rakie.kim@sk.com>
 <20250404074623.1179-3-rakie.kim@sk.com>
 <20250404140559.00001112@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250404140559.00001112@huawei.com>
X-ClientProxiedBy: MW4PR04CA0259.namprd04.prod.outlook.com
 (2603:10b6:303:88::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e1ac95-397c-432e-42e9-08dd739d611f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KJTUV5Btg36mbTSFx6rUWTxMQhBw/DKmcCy2JCJ/ihqToAWi7p0fu04i2YxX?=
 =?us-ascii?Q?d/tS2zfQU+6X1rieldnOn56kVfg4371zyWiyqLq7ryu2bwKNoqqamDJ7QO1n?=
 =?us-ascii?Q?36/FSNi0uXdXqDzzZ4z3kIqlMef5LpS92Wz5g45PkA5rngTMtcEJnKypU1wl?=
 =?us-ascii?Q?/0LGeTbaMDNlNytvwa0HEJo0STFfaOxhyxHfetX0WS18z1Pw9kAMpy3dk80S?=
 =?us-ascii?Q?PaoaNQvFsd7fdKM80OSTE9AIIYbUnyVhvX54iJFULFkXrj2oxGaRm/EAMRpt?=
 =?us-ascii?Q?tthVLjfbb64kcbMpUiboLRUGGIqwmfPnlcISWX3Zzovg4LyUqcdvyuP5kmQD?=
 =?us-ascii?Q?gbb5Y+4aICL7/i1th6Ba6s7MoGlpYcrU8HmclmU54Hucwpe73tfALXGMDK6V?=
 =?us-ascii?Q?kd1TxpSEFfK6g/AaoVvDl2AWygU+IioYRmqyrLC9EIGxvLQnGAdUgNRNJv9Z?=
 =?us-ascii?Q?veSmbUZt8t6wbc7e8xWk0CKVKqdjD7Fy+ctLDzXaipTaRoJdC4rT9sakMANo?=
 =?us-ascii?Q?RW8inZ3gv7f2VWvDbs53cxdXH84LrW/KzpHWoV5eRdc383GMd45WHFMONL6z?=
 =?us-ascii?Q?e/kY+1+x4lKwgw/5BmQWkYPCvZm3fw9i8LS5nHFjZfPqbT5sD/VfjuEmdp/s?=
 =?us-ascii?Q?rV9fzvarsdBqPZdhi6ge9ezIAtQKsdE09N6mfTZcy5t0NIQl8INNjlfapOdf?=
 =?us-ascii?Q?Rth7+E+Wvh670zoCnqljDVJoYBXsFPZ+i8i4UQAq57NHNEd9/AnONI7PoVW0?=
 =?us-ascii?Q?z8l7vIhxSg1+NIitKIaNZnWwLu54qv2H45l+jc90Cl3M2kGAY+EcL2Tz26r6?=
 =?us-ascii?Q?bri2F94XIB3Mmc8V+1nRyQah26dmRp7ytXzhXcGNsEQtu/IpBEY5Qv4s2WvK?=
 =?us-ascii?Q?7YDMW6/6kpx8GyWeuFE3rilyN9G8Nkql7DeXkn7ZWjR6dtR75cDM0NsoX3OT?=
 =?us-ascii?Q?h/b1Vz2OhCcq1d11b1A6R/tOxtOackHzhfd8nOhjtKZs7jswLJfVBg1nWone?=
 =?us-ascii?Q?gKou1irf4eE+f5erY8fNJK9oJOFqj/lpO6T5iss8NucLpYctjjA6iVv0DQuA?=
 =?us-ascii?Q?6uONut4fkqFnkIidkO7PnrblrJcKWG4KRIqXeZtF0XdXiZkxMcstSmufqq7V?=
 =?us-ascii?Q?Xywp75yK+jgS1uI/6vT1pUcPrreNf4czeGNZE/fsbFwubpvCnxwDg3w5hhUh?=
 =?us-ascii?Q?kZ6BcHgkDCB8sqo6/6adFANgo5h2GYdnbj+KbRqnzviD74V24D9kdRqU0qE/?=
 =?us-ascii?Q?sc9VZ+aSzc6RI0M8IVgp42gbHNM5wrw4duCq1DLPn2v/pXYxQ+A7t+OA24Q4?=
 =?us-ascii?Q?KunctioYjbmO5A9uwPsxiZFLM/MJDxwDhT0B6Jnbn0ScGhBuR4xjMwozU4Qi?=
 =?us-ascii?Q?giRd2RIVQyjSd2ecePsgVFHHAc0X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K+/R61ANv8UB7OJOhMT4OSy/DjPXIgKGG4NU5p1FWg2Y5jHpoSiumiN6pQjW?=
 =?us-ascii?Q?h0GZOjVbzac2Rrge7QMUmwVdvIy7XodNf0KkKFON5KAG07YlYz3yJC7//S9g?=
 =?us-ascii?Q?MY1r9P0fGX5xZ1pUhyZx0p4rqoBEm+i2K06Z14+u0yt53f9eAI7yosJf0oJU?=
 =?us-ascii?Q?HetFpd/R+34991rmarMHWr0nzgayVncAnd7YNmE7Wv1uBvSM8abwmIMVOYzy?=
 =?us-ascii?Q?jSicD2csfZ8kAZe+DRIWP0UHl3vEPCPm/rtIJZpt5bRPkeNMW/31PGvMGcyf?=
 =?us-ascii?Q?p0ma28M/32olXGPgrZrTrO/wBnDcR1KSBK914r4aoORwKwpKW8vhvYmBQFRl?=
 =?us-ascii?Q?mvEsiQs67xAnFgcFr4jJHB8RcK82t7LjumpGiQMHdSu+zdVYfv8ivbBs79gI?=
 =?us-ascii?Q?lNgfR0cv8/+1wkubiv6+Oshb69tNROCsOIkk64KUpj1z4AavwErEvTBTomn1?=
 =?us-ascii?Q?CZ0QPJf05PSn98MojTPPkzpdzFFJYwm5gqs8MM8IUs51KVbSv9b/8E6XE2qL?=
 =?us-ascii?Q?Gk238pmSnuIjgBIP0Ya/wGAOnU17U5AcEZ3xo+i6+VWWMJ/pPwvKift5s3t2?=
 =?us-ascii?Q?eTGMs/B9WmbtVUuM3YJTabjiXyT9mpNjy33FMAYDULJNquYj5mQswhkc0pM+?=
 =?us-ascii?Q?WdyDjzjP+wCjm5gwIW01hF6aJ5A7aW276af+0NW2WZHU/z0nbXGDNVNeopTW?=
 =?us-ascii?Q?TDXayyKxSS19iCnHbdwX7huerOJRv6z3kiiZNM9KzhW7FTV/NfI02RiasKHa?=
 =?us-ascii?Q?seFxID7yZpcpRO2qSh8e0kGpOQODx1gfEgX0FcAmQzuhhxhERr9XwZJRoqSx?=
 =?us-ascii?Q?xp1GzFWuMN7lnfv4Z1W6jdfi+BmIR69NYrdPK3YAtGuUdBM6FkeyRWcngC29?=
 =?us-ascii?Q?wk6iKi8cQtzeeeb1hFyqrVTN2eMmxxTHauNui5GYA1nPO1j33Pc7ASUCZBVL?=
 =?us-ascii?Q?iA5BZiZBtc5QIKaNngqhTDXSpUkgB/FII1rJJQAyDIos/MGi98YdbzZtOQuk?=
 =?us-ascii?Q?TdjfMBGETJk/9datLfDLO9wxzAT5CaH/w8O1C7VOXBOpC9Ul/l+XslJ/AOAK?=
 =?us-ascii?Q?UhZfzuHC+GtWcuKnYzTcAPfbUF8yymNfCwLZgYk4zvyaW0bFUz9hZHrL7aCy?=
 =?us-ascii?Q?ipce4zPgKb6xLqOTErm1CvKS6AsctDvUeyq9dlAghQgbzcIBgn97nWBnspWc?=
 =?us-ascii?Q?XEoNRbdyCI3Ews3BRK4NmY2BTtB0exY+ohBfYE5BkV5Vzjg+rg+bS0nr9FJt?=
 =?us-ascii?Q?bg1NIVMtppqNy6dr8iEFRk3ilonPQ1ytp0ttPG4xiqpcdE13RwHWzUkk/8so?=
 =?us-ascii?Q?9HI/iGdIOyRMXJRvJGD4U8f+1TjJUkHJoAOX05w8GUgQLISZhVLHRqmL+L/D?=
 =?us-ascii?Q?5720A9VcA1dQ1QtOXcuzVpsQRh5S5n0dBx54k9+ewX3qhXb/6kaCB+kdnyS6?=
 =?us-ascii?Q?pniMGMKzsoRxcbBOCjVhwco36X0Nd4YnHy6Ear6/pM1Kwtt7/YAt9c+vMSX4?=
 =?us-ascii?Q?oGBGGvjrxh0izuQCcmbwH1yHFznwfuNi+fxhIF2+7bta2fQIdM3DXQv8TKlL?=
 =?us-ascii?Q?0+7sWFFfOF5MaAotsfO+menUJ40JaXWGiCI3ns9Ox+Rev9GMoknI4yT60M1o?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e1ac95-397c-432e-42e9-08dd739d611f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 17:23:13.4466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUPzooGBPUd+V5zK/VmCpeK/hnvMizzrXSXzWHDtEn9DvSy1hpo9I2yXvMHe/bTivnzuJXkKdAEX35ADqZgl9NOXJsTJZ1jbU4mZSPX+Ze4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7310
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 4 Apr 2025 16:46:20 +0900
> Rakie Kim <rakie.kim@sk.com> wrote:
> 
> > Previously, the weighted interleave sysfs structure was statically
> > managed during initialization. This prevented new nodes from being
> > recognized when memory hotplug events occurred, limiting the ability
> > to update or extend sysfs entries dynamically at runtime.
> > 
> > To address this, this patch refactors the sysfs infrastructure and
> > encapsulates it within a new structure, `sysfs_wi_group`, which holds
> > both the kobject and an array of node attribute pointers.
> > 
> > By allocating this group structure globally, the per-node sysfs
> > attributes can be managed beyond initialization time, enabling
> > external modules to insert or remove node entries in response to
> > events such as memory hotplug or node online/offline transitions.
> > 
> > Instead of allocating all per-node sysfs attributes at once, the
> > initialization path now uses the existing sysfs_wi_node_add() and
> > sysfs_wi_node_delete() helpers. This refactoring makes it possible
> > to modularly manage per-node sysfs entries and ensures the
> > infrastructure is ready for runtime extension.
> > 
> > Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> > Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> > Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> > Reviewed-by: Gregory Price <gourry@gourry.net>
> Hi Rakie,
> 
> Some things I was requesting in patch 1 are done here.
> Mostly I think what is wanted is moving some of that
> refactoring back to that patch rather than here.
> 
> Some of the label and function naming needs another look.
> 
> Jonathan
[..]
> > @@ -3430,27 +3437,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
> >  	return count;
> >  }
> >  
> > -static struct iw_node_attr **node_attrs;
> > -
> > -static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
> > -				  struct kobject *parent)
> > +static void sysfs_wi_node_delete(int nid)
> 
> Maybe stick to release naming to match the sysfs_wi_release()
> below? I don't really care about this.

I had asked for "delete" to pair with "add" and to not get confused with
a final kobject_put() callback.
