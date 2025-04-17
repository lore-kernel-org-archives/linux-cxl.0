Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62367366;
	Thu, 17 Apr 2025 03:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744860219; cv=fail; b=f8h++Y2BUiTywuBsgA+yHGjTyVIAhz6/VKvTeJ4DBTDS8TzcV5LeaFDmPHhlxlKzKwlJeEtl1kcDrTmyJesQRi5JOoK+LWIhPZpvUkeWSetA49LGiEEaoGu6EJ8JTZeDe40aLxwIKcSpBGUVp+CDyH2Hs+/l3iG/pE+fQTWaKv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744860219; c=relaxed/simple;
	bh=JnxstbNwY7ep1KERSl3TQX/hw8S3e35K23nv8+WMKp0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XTrD9lKa64VRUIn2wN8hw2HbkfwcciO4olQJJLY6wa7xKVKxEEaMGzf73dnLGpWzzvC9IOFV5Ti0axX1hUJuToo2cJGq/O5a71LZvmUsJVJXigGHVKi/IUbOVFwBcp0jMnryKp4AMpAMSHgdIgHjfSOHgrxnvt1TJ0nJbAAxll0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AC48oLTE; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AC48oLTE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744860217; x=1776396217;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JnxstbNwY7ep1KERSl3TQX/hw8S3e35K23nv8+WMKp0=;
  b=AC48oLTE361BIYlJMdFdfuNrfs+NKfMu4n5ti2VvE4o9n25DmjOEuqZF
   y6YFneGagMYyOOkhFm8RU0qyNrj2O7SjKMmUOEYNzKO1pggzLcKJoO652
   PzI6QVcYnXBctXdEVDTSZ0boCzRySZdnIOfUgfbGKFwc2O78X6puSXSYY
   whsqh9C7no6RBfBV+Khkz5oxLBaWZgzypASUsS+v3+UscLnLylWV3EFT3
   iTU82FKlQ3CPa5vS6E2iIzakHj29y+K2092tVT3atnmAnDXwTRNizvD6G
   F2E8L0YCjUemgOm87fBjxW5nvhVm4XyTQT4efOXWfXM5P8zbDbrOiO0Z0
   g==;
X-CSE-ConnectionGUID: BJX+gynXShirgmNGuvcbmA==
X-CSE-MsgGUID: HWMshFA2Rnu8tqjaibYraQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="71819149"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="71819149"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 20:23:36 -0700
X-CSE-ConnectionGUID: OjFcOAHgTMiOOpPO9+ywAQ==
X-CSE-MsgGUID: nMtlgW9AReGGFy1P5Y6xhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="130631694"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 20:23:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 20:23:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 20:23:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 20:23:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRFqeszpcrCk2AA5T+7gxbIT9aqzYCzupuw5phuisfdIKDPFQuwKUoTWAaSejuEhycYQfLNPvcMDRXZkB2gzjadn+tNBXnf0MB6ITIHb2aUl5l8qRk4xIiqHM0EqiIAIH7Lo9Cnto8AU5SXaK3HdPFyzWpVyU46d02A/0eyJR4/UfZVBrgDGHSd5/vfdyipDHyLRp5M7uz9h6Ls89HeKuNUNBX2eIJ4iZYQv6BYSlbL2aBP2JlILZtSbMYRtWtBSc5NNM3T28nkRt2g3moGutMM2qVEj9jlOnUHSxSI80r1MdVmxXDUD0zFLcGT5lxapF3BJcScqg/ilJ2m/wXpbvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNrSq9Bg3kE1j0sAhoEPSlJpHucleUWBCplumiHt7/w=;
 b=lZCqU2os9iCD/hvO4ff5GX02JfK2hOEpEOu0sycCilUvn4T3AzuArEQ0fAyi8/P9Y9sKwnC+bTp6wbG7T8rJlT8M2RYpU8WRf1Fbmjfsgq9lnOATOtJLupf5mabGGku3TG6vXyczfEDwgE3H+YBiWa8HzpLEXPcyfbOsxku3kUarW8qf0xbKitcAF4T+Z4SLcjeMObflKAmP6jllTU7MoUTYCV5pgrjCGgmHeZ9mrAfGp+gBA/REhtpaUHPAIPQZENr7Huq1w8PUBwLM0BBJJPj8QcY4UQOKWNGdgNYtQMxRdyxKcWz+dQJFFosJth0/kHqQjAp/aDTaVj8CuDLHSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH3PPF496D5EAB2.namprd11.prod.outlook.com (2603:10b6:518:1::d1c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 03:23:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 03:23:29 +0000
Date: Wed, 16 Apr 2025 20:23:25 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Rakie Kim <rakie.kim@sk.com>, Dan Williams <dan.j.williams@intel.com>
CC: <gourry@gourry.net>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <joshua.hahnjy@gmail.com>,
	<ying.huang@linux.alibaba.com>, <david@redhat.com>,
	<Jonathan.Cameron@huawei.com>, <osalvador@suse.de>,
	<kernel_team@skhynix.com>, <honggyu.kim@sk.com>, <yunjeong.mun@sk.com>,
	<rakie.kim@sk.com>, <akpm@linux-foundation.org>
Subject: Re: [PATCH v8 1/3] mm/mempolicy: Fix memory leaks in weighted
 interleave sysfs
Message-ID: <6800742de6315_130fd2949c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20250417015009.650-1-rakie.kim@sk.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250417015009.650-1-rakie.kim@sk.com>
X-ClientProxiedBy: MW4PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:303:8f::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH3PPF496D5EAB2:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4ebce7-86bb-438c-69f1-08dd7d5f391f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Uz+toqhuvQKo1IPmC4bqEgduWoyebFDiNdX0pRQqzoTEucs0ty37asFMEjpq?=
 =?us-ascii?Q?EeXo9WUxVsuQxETy1G7nTgwSVTw6+nh/lxpirC2IkFqbxkq5jiS10EJRVJ2J?=
 =?us-ascii?Q?5e3buRhTjDQ8Fov+rwuW/HN9h1x0cejamL/HxzT+6/ffhslJQKuDENRVzeCe?=
 =?us-ascii?Q?/bxk4f9CGQvxR90tlWoYT346/YzLUPnTBHR/e/VavQtysFTs/MC4lQmsbTIC?=
 =?us-ascii?Q?1Ydn1fCt9juCSaOgmaz2G11Nwek8sW24AHqoRjDgPIfPyFGbcllZKaHEjBCD?=
 =?us-ascii?Q?wlymmVupw6WYGsKvHeKcssG9kTGv/d5qet1eG6khY6b6Gk11U8J+F4u0V1O+?=
 =?us-ascii?Q?OoVwOKan7sBlYFtG7FY+1KzCyBdviW6hx+87u2UVlXINePgB2G12cshs3/Q3?=
 =?us-ascii?Q?7LYfAlphPWK77fEIvTZwIK7WAzEditT1rDsZApj/80RCwWiI6ies1GdCcIJt?=
 =?us-ascii?Q?jHnWyTZzAD/hCzo/4Bgxy/QVcuk4gcFAxIV1H34bffcU6rxauUIxMZ5Wgxex?=
 =?us-ascii?Q?58ukWBX2szicsaUBIiRaRe+JyLJCxGSk+VW5hRNULEaYmD8dwBR4G+uQZMfC?=
 =?us-ascii?Q?HQZ28lmQd3kz00qxssjgEQ6JSD7ebGb18RBaaLzb8sAmEFWHKbgH6vF1leLv?=
 =?us-ascii?Q?DFmUzN6CMIygg/PVBhJOUWMhXdqfQD0Agw9tmIrfbA9vxksaqmn3bIPK6fIp?=
 =?us-ascii?Q?OnRnIcLq7oqFLNuc0G1NQIUrRCHhj3XOTCJYJf9O98vBCfTj/AxMPA72q6YJ?=
 =?us-ascii?Q?REsQV7N4nwKaGDRiynkq6Keuo22AqdRtIfULBAuh1FqFWtr3fnIbXAavBSer?=
 =?us-ascii?Q?GC0HumuDGljtOVW2F5OhCezfK2ru7plshSNfgaX5FAR0vE9b3TiqYgPwoN00?=
 =?us-ascii?Q?DOwOQz4Wy3N9U/Rem2iLnO5XIaCbbn9F0wLYodFmYAKUm3i/ZaCOhcosZJ66?=
 =?us-ascii?Q?89oVa5Og8vBWOeZKh+mcXSC9VOFT5nhCu95Rocgqv0rIMXaz06Vr3N+ogt41?=
 =?us-ascii?Q?9g8zLtXnHWNCMIC8qodbcLdFML9wfYlzlSMv5EwcxiSd3DMeP9wof8SSPM1b?=
 =?us-ascii?Q?0MpsWAZFxUpwWzIPGggUBy0h+2jMUgpMYLHv1scgTXB0WsHLPvic0KxoUjdV?=
 =?us-ascii?Q?ArQiqCcPxbRW5ogXQUBxL/uVfAekdhy3iDE2H9/P59BptnD9MeqtzTeebhpV?=
 =?us-ascii?Q?NRhNBbPgwfrpG5eojXE+LLo/BU1+2zgwqhMvCp7g1jBVIa0LE+STu6ch3hFN?=
 =?us-ascii?Q?642p82GGBnmTiNe2WXhqxX8vT/SGQo7vHxzmPxKnFYtF6MBReM/UkhdQ3ctQ?=
 =?us-ascii?Q?n5cT3X6jT52couOaZo7dBE7sZr49sdvVc7HPw+9ATqTjEPWuF6aCp7IzhYxw?=
 =?us-ascii?Q?/+37NyW2eY+VFPXNAAprs+1v8N5I4Dh9lit/7R3ptPH8/Qm95f5RML41IIjY?=
 =?us-ascii?Q?ydVTNJ9dqBM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?svQYcS8C+U1MWsxUvY9U+1C5vjV3CZ2Q4Fp9BeAXsqv+ITCWsKYPhHl0kke+?=
 =?us-ascii?Q?aQsvZ5c/7QmvS6iuiKzzzmro6D/Gur1HpVBnd7VhRbQpRXD5+zF4x3qjN0l0?=
 =?us-ascii?Q?qEvu1yP8Cu+pBRls/ADr31C2UFf08SRt1yK1p+JYswa/Oof1jcVttBTel+cI?=
 =?us-ascii?Q?+t4rNFGEm5MC7s07CrZMPY5wxZyiTmniU9tVnvoG+IL5ADoQcsAACu/tOuPk?=
 =?us-ascii?Q?ILjTO2KF36bmHW7LYDPu25iKqrWaw2GchKbcyiEj/ke0fQj/beVkIsTAUUtK?=
 =?us-ascii?Q?vGF9Nuac05u6c3w3MuClw4dfNdb26OjPN3VHP0ISyZZifByQy5E14TytX0cS?=
 =?us-ascii?Q?60/G6CBnlkPy95j+/HQlnJ94TyGaERz5PiXZ09pSY/S1w4kkt7vbCRmir864?=
 =?us-ascii?Q?T9BYqlgjiUMO51NrEDCxHsmSxYhfikozqdgiqj2CeenufLTUCIklokBq3Ufd?=
 =?us-ascii?Q?hi35wx2PYKihDRHnM8IXfXK054m+UqRn9+Qcm9bhWC/CD28pmxvMC9UMKIBM?=
 =?us-ascii?Q?Ne+zBEwQFHRWCMbg15SSPBBkVHaVKmduQKFGQLqtlk2b7zD6HvfhcPNb3Foi?=
 =?us-ascii?Q?SEr3g8kfGJNpKRJSmN9IM+if2/754XFrrAQnv4axVkXA9FgmO0iwPnX1idzQ?=
 =?us-ascii?Q?g/t7zVbstpC6M4U48GV4J8CJfpIOg+MKpz4Q/a+UrTdUzzpsrfOVc72Xwmq3?=
 =?us-ascii?Q?Sn7u73PAnqRoWgW7J2Esy97Au3FO5qdgRs1MUKH9NfOnvkFSkZ8Q9n1vJ5G8?=
 =?us-ascii?Q?sFOCko6WVTAlngv3WisZv4YGIacQOGIKpHEa8BriSHRe+AaqAIANkXFf8ou5?=
 =?us-ascii?Q?6TixHTj98+a6eTWhrbRSQ4X7V05Kc6+0XWXANRviMayGf/gHc4IAGcYnw8A8?=
 =?us-ascii?Q?ncoYV4pe4co30dFb9d3Z38DLE+QmDd+KiXOf/8BPs/94Nxd7I4Xe5SJz/65W?=
 =?us-ascii?Q?dU1TnWdTd4R7MyMxPppng9n+YedVh6rw9UrRk62WhcCiqlc1uwu+ePWKctHG?=
 =?us-ascii?Q?W5YMDrFeyf+UyI8EmcgtdDiub4T4zNG+gcFzdcjDz/cxG06f9S0B8nYSBkHB?=
 =?us-ascii?Q?vrhzaC08vbGyQxqWv3wbWivxpwE2LOUVpWjPiW3dnHEI7ESFaW1SH3QTxcTj?=
 =?us-ascii?Q?CgD6Rynu/n+WtMyGf7TkeMwkHsX0bHe3pSKnAQ8GTSKnS4fs+PH+f25mylRM?=
 =?us-ascii?Q?C8LcpkzwzgHpEW90MDBvW4XCb6zFLvjhqb5dbq9esfk37VxLqCxzydSB7q2F?=
 =?us-ascii?Q?kRIPBgrZbJJqw/DT7dDVNBRr9djVuLWuCPFn1SRw1MM4CmvmDjYN7dOhyF0J?=
 =?us-ascii?Q?7b87u2UB5v2SyFyS0UspkCvDiQ+fheHQkRO9ScTLFkP4q0Kc3ZVCSTQiPnru?=
 =?us-ascii?Q?joFrp9k/9HzDFbcuTjCelLHCDwQln499JrfQAsYzK/zod38hf7DtWOqkla8i?=
 =?us-ascii?Q?w2MVqe4bTTA598WUpgXOSjrPHpPakrYHaQWrcfTTgIVW+bhk6ihTq4QORzgL?=
 =?us-ascii?Q?dZNMZcTZuU6vq0/E+LhDfAbsF4ZXRsk0XdkroGVX/Orbyy7/P4CBogapNOpK?=
 =?us-ascii?Q?GLRyYuHJiT7RjFrBIPpGl092MAwfhZSK8IxsQiN7t3RVFfmDg76eap1he16L?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4ebce7-86bb-438c-69f1-08dd7d5f391f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 03:23:29.1357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XWB5n7tJrv1TGKRik1JWAxISQdB31VxNthUgmXS/7xWtN2JzJ/3Elw88WXgYGqr01BlAi5/JDmOm10TrurT7z4NpuAhkhB7iX/n0EMXQlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF496D5EAB2
X-OriginatorOrg: intel.com

Rakie Kim wrote:
> On Wed, 16 Apr 2025 14:54:16 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> > Rakie Kim wrote:
> > > +
> > > +static void iw_table_free(void)
> > > +{
> > > +	u8 *old;
> > > +
> > > +	mutex_lock(&iw_table_lock);
> > > +	old = rcu_dereference_protected(iw_table,
> > > +					lockdep_is_held(&iw_table_lock));
> > > +	if (old) {
> > > +		rcu_assign_pointer(iw_table, NULL);
> > > +		mutex_unlock(&iw_table_lock);
> > > +
> > > +		synchronize_rcu();
> > > +		kfree(old);
> > > +	} else
> > > +		mutex_unlock(&iw_table_lock);
> > 
> > This looks correct. I personally would not have spent the effort to
> > avoid the synchronize_rcu() because this is an error path that rarely
> > gets triggered, and kfree(NULL) is already a nop, so no pressing need to be
> > careful there either:
> > 
> > 	mutex_lock(&iw_table_lock);
> > 	old = rcu_dereference_protected(iw_table,
> > 					lockdep_is_held(&iw_table_lock));
> > 	rcu_assign_pointer(iw_table, NULL);
> > 	mutex_unlock(&iw_table_lock);
> > 	synchronize_rcu();
> > 	kfree(old);
> 
> I will modify the structure as you suggested.
> 
> > 
> > > +}
> > > +
> > > +static void wi_kobj_release(struct kobject *wi_kobj)
> > > +{
> > > +	iw_table_free();
> > 
> > This memory can be freed as soon as node_attrs have been deleted. By
> > waiting until final wi_kobj release it confuses the lifetime rules.
> > 
> > > +	kfree(node_attrs);
> > 
> > This memory too can be freed as soon as the attributes are deleted.
> > 
> > ...the rationale for considering these additional cleanups below:
> > 
> 
> I created a new function named wi_cleanup(), as you proposed.
> static void wi_cleanup(struct kobject *wi_kobj) {
> 	sysfs_wi_node_delete_all(wi_kobj);
> 	iw_table_free();
> 	kfree(node_attrs);

Looks good.

> }
> And I changed the error handling code to call this function.
> static int add_weighted_interleave_group(struct kobject *root_kobj)
> {
> ...
> err_cleanup_kobj:
> 	wi_cleanup(wi_kobj);
> 	kobject_del(wi_kobj);
> err_put_kobj:
> 	kobject_put(wi_kobj);
> 	return err;
> }
> 
> However, I have one question.
> With this change, iw_table and node_attrs will not be freed at system
> shutdown. Is it acceptable to leave this memory unfreed on shutdown?
> (As you previously noted, the sysfs files in this patch are also
> not removed during system shutdown.)

Yes, and note that most drivers do not implement a ->shutdown() handler
which means most drivers leak allocations from ->probe() when the system
is shut down.

> > > +	kfree(wi_kobj);
> > >  }
> > >  
> > >  static const struct kobj_type wi_ktype = {
> > >  	.sysfs_ops = &kobj_sysfs_ops,
> > > -	.release = sysfs_wi_release,
> > > +	.release = wi_kobj_release,
> > >  };
> > >  
> > >  static int add_weight_node(int nid, struct kobject *wi_kobj)
> > > @@ -3525,41 +3548,42 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
> > >  	struct kobject *wi_kobj;
> > >  	int nid, err;
> > >  
> > > +	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> > > +			     GFP_KERNEL);
> > > +	if (!node_attrs)
> > > +		return -ENOMEM;
> > > +
> > >  	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> > > -	if (!wi_kobj)
> > > +	if (!wi_kobj) {
> > > +		kfree(node_attrs);
> > >  		return -ENOMEM;
> > > +	}
> > >  
> > >  	err = kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
> > >  				   "weighted_interleave");
> > 
> > If you fix wi_kobj_release() to stop being responsible to free memory
> > that should have been handled in the delete path (@node_attrs,
> > iw_table_free()), then you can also drop the wi_ktype and
> > wi_kobj_release() callback altogether.
> 
> I understand your suggestion about simplifying the kobject
> handling.
> If we only consider Patch1, then replacing kobject_init_and_add
> with kobject_create_and_add would be the right choice.
> 
> However, in Patch2, the code changes as follows:
> struct sysfs_wi_group {
> 	struct kobject wi_kobj;
> 	struct iw_node_attr *nattrs[];
> };
> static struct sysfs_wi_group *wi_group;
> ...
> static void wi_kobj_release(struct kobject *wi_kobj)
> {
> 	kfree(wi_group);
> }
> ...
> static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
> {
> 	int nid, err;
> 
> 	wi_group = kzalloc(struct_size(wi_group, nattrs, nr_node_ids),
> 			   GFP_KERNEL);
> 
> In this case, wi_kobj_release() is responsible for freeing the
> container struct wi_group that includes the kobject.
> Therefore, it seems more appropriate to use kobject_init_and_add
> in this context.

Ah, ok, I agree with you.

> I would appreciate your thoughts on this.
> 
> > 
> > I.e. once releasing @wi_kobj is just "kfree(wi_kobj)", then this
> > sequence:
> > 
> > 	wi_kobj = kzalloc(...)
> > 	kobject_init_and_add(wi_kob, &wi_ktype, ...)
> > 
> > Can simply become:
> > 
> > 	wi_kobj = kobject_create_and_add("weighted_interleave", root_kobj);
> > 
> > > -	if (err) {
> > > -		kfree(wi_kobj);
> > > -		return err;
> > > -	}
> > > +	if (err)
> > > +		goto err_put_kobj;
> > >  
> > >  	for_each_node_state(nid, N_POSSIBLE) {
> > >  		err = add_weight_node(nid, wi_kobj);
> > >  		if (err) {
> > >  			pr_err("failed to add sysfs [node%d]\n", nid);
> > > -			break;
> > > +			goto err_cleanup_kobj;
> > >  		}
> > >  	}
> > > -	if (err)
> > > -		kobject_put(wi_kobj);
> > > +
> > >  	return 0;
> > > +
> > > +err_cleanup_kobj:
> > > +	sysfs_wi_node_delete_all(wi_kobj);
> > > +	kobject_del(wi_kobj);
> > > +err_put_kobj:
> > > +	kobject_put(wi_kobj);
> > > +	return err;
> > >  }
> > >  
> > >  static void mempolicy_kobj_release(struct kobject *kobj)
> > >  {
> > > -	u8 *old;
> > > -
> > > -	mutex_lock(&iw_table_lock);
> > > -	old = rcu_dereference_protected(iw_table,
> > > -					lockdep_is_held(&iw_table_lock));
> > > -	rcu_assign_pointer(iw_table, NULL);
> > > -	mutex_unlock(&iw_table_lock);
> > > -	synchronize_rcu();
> > > -	kfree(old);
> > > -	kfree(node_attrs);
> > >  	kfree(kobj);
> > >  }
> > >  
> > > @@ -3573,37 +3597,24 @@ static int __init mempolicy_sysfs_init(void)
> > >  	static struct kobject *mempolicy_kobj;
> > >  
> > >  	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
> > > -	if (!mempolicy_kobj) {
> > > -		err = -ENOMEM;
> > > -		goto err_out;
> > > -	}
> > > -
> > > -	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> > > -			     GFP_KERNEL);
> > > -	if (!node_attrs) {
> > > -		err = -ENOMEM;
> > > -		goto mempol_out;
> > > -	}
> > > +	if (!mempolicy_kobj)
> > > +		return -ENOMEM;
> > >  
> > >  	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
> > >  				   "mempolicy");
> > 
> > Similar comment as above, now that mempolicy_kobj_release() is simply
> > kfree(@kobj), you can use kobject_create_and_add() and make this all
> > that much simpler.
> 
> For the mempolicy_kobj, I will update the code as you suggested
> and use kobject_create_and_add().
> 
> With all your recommendations applied, Patch1 would now look like this:
[..]

Changes look good.

With those changes you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Thanks for all the patience with this!
