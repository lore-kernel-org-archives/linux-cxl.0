Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D848479;
	Thu, 27 Mar 2025 02:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743043894; cv=fail; b=kLWzc7E4T9VDueF5KsCk2blWgN/E6TbGAHmMlDjsLCI6tWe4XvhJhks4uuDwp0JzVGb6kvQAPUIjrlFefxePgP3pzwWzWZSPi5PsaJzIsNhqkCvUIT3P7RVFkaBkgQFeca3zDJ5axrsDtnZgzJXoC68uo3nrQpI0dlZ9fx3/TgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743043894; c=relaxed/simple;
	bh=F/C/PnlvOCgxR0DcEYu0I1pAQor6iQwU4d5OtPSXzyA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XIAASI79BXtfI+WH7DCcE+AhCEKK7Xcen075uaZ0RstBomeeX1Yxu3McXsSSGMAU6Y+mD7beO41EDuLEQa/l2FReSCqPek/FZqfR4j3oOj3kBJA9d2C8UrmSUL/6B5DsqnBAu/4TlYK/dOJh7uRwWOWlQKR2033EJkAfiRdbFZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDrIpmI4; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDrIpmI4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743043893; x=1774579893;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F/C/PnlvOCgxR0DcEYu0I1pAQor6iQwU4d5OtPSXzyA=;
  b=fDrIpmI4vQ9rJgNxdkNglKNVp6CvVaOd9WyVmghH3EX2VkRTPhNq0KpK
   HEAgHrLH6VUCQ9d3zZIVnyjtEyw2GKww2Mtpl6xg1Gc61Mh2C6KLkLm8O
   GChGvlf58N15Utbyi0TJWt7jjdAIs33fRfx8pyPjpDXgOwRdnJclgTLFt
   N9AQPeYdHqVFgWmN327T8D4vcVPv1Ty1epSNenDUk5TW1L4eritVCaKS+
   vOC9BY5+VQw6kaxOSgNANFFGZQriD/xDRacAlML3F4JJjJNh/7HokQxRP
   IKLbsv1YVPLOdhJdUbEDg5LprZxfy2ez8fnGlf7nO0GyaE5Eont0M9jZw
   w==;
X-CSE-ConnectionGUID: 9NbUVmJ4Rzy90DTfDyI9Kg==
X-CSE-MsgGUID: 8cw2C4/WSD2lSIBAsprucA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="47094607"
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="47094607"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 19:51:32 -0700
X-CSE-ConnectionGUID: vFE6raewStuKqfWLOWZyCA==
X-CSE-MsgGUID: fQT+HVMYRIKOu31Bhth0+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="162237757"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 19:51:31 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Mar 2025 19:51:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Mar 2025 19:51:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 19:51:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxNTw8+xUNAQa84Mrhf76OdmlRE7UENwpZ8yhtrVLCZGYgtMqA1TW+n8NLWBIJh+snZOA6OaSMhyS9Nht2SlaZlRnzUQ77ujwK6eds7BqyflEClaQMwv+cK8QMfHxrSR5G8JH6UBxHyOU6idxGm3nqpQDLvJq+l94B2tqmoA0L76xlaY7/WyglF7Detp2u3jCOfGKruQZpPTJzCDUKY1slPGP/9ydVu5lS7wJTsorgcT1LMTVLOjudjIHMtpELOqzW51yAG2DXZttCGkDxDKC/c2u5gZfhmF9JCUy55towXJr+cYM9f9yh/33Bez/93jfhHNmcp9WwXtltXJ40k+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSPtvXnsCneq8G1OqAHteBGwhblpHLD/H4iecaOJteE=;
 b=mj/BPw7ugokMEWE9BNxj6g4xWrwwzAOoLl3lCuQbR2d/on5wvk0iukZx7f0n5f3pNP1di8h50SXxTwPCfoYBrZ7IUvdGGWLtPyh/Pi5RA0dQ4K1MRElSzwBT3JCo+cHIjwiZiW3q10C95AIP4Bfg9icC1ye9tdXIg7iDMmjpaSVe3iZ/FmIeKLctd0cadYO6vXgsUBDZSALwnERoUGAT7Ky8oAwOhkOl/oOr8WI6gcHuaFtTaHC5Nc5V+YYh2Vd09GaFxsXWvv9ysOoTALOYIVzKDW6WwTjvFYNbTAHuTO58AwfoGnwuYGQr7jZ0Iun1m437RbZFvcHW6bZmxXdI+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA4PR11MB9059.namprd11.prod.outlook.com (2603:10b6:208:560::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 02:51:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 02:51:14 +0000
Date: Wed, 26 Mar 2025 22:51:09 -0400
From: Dan Williams <dan.j.williams@intel.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>, Gregory Price
	<gourry@gourry.net>
CC: <lsf-pc@lists.linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM] CXL Boot to Bash - Section 4: Interleave
Message-ID: <67e4bd1de1282_152c2942c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z9DQnjPWbkjqrI9n@gourry-fedora-PF4VCD3F>
 <Z+PIoAGgz33R2c3P@phytium.com.cn>
 <Z-P4ulrFQAbJBC_A@gourry-fedora-PF4VCD3F>
 <Z+S1+wThBGHe888e@phytium.com.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z+S1+wThBGHe888e@phytium.com.cn>
X-ClientProxiedBy: MW4PR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:303:b7::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA4PR11MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ba09ec-25fb-41f3-a9c3-08dd6cda3cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7uk7ACliZfxyWmpIxXsWeIq5HjWfEzl/nDMKRQI/wOl8mQtFPik8X93xADSG?=
 =?us-ascii?Q?u6nAsOPKJn04WOrl+w5rbqLxtoLemAkVXmKYkBQnpfF6g4TfCwWgHe9qF/dk?=
 =?us-ascii?Q?jb3aVkqMK+XUd25l0b18VytMaRYEygY1FhvLrh1QfKjEW64LOXORnuYV5G5X?=
 =?us-ascii?Q?S+TKdDGTbtTjgTc7wR1L5UJvYxva8pOvfJoDrlZWwQjRaFItBBOPkHUcZdw/?=
 =?us-ascii?Q?9kj4AX4T0rn7FbH0teQX0OQ9AMZnFCrCYu0OVchqELE2RqkwRXIuSatO4HCg?=
 =?us-ascii?Q?8vtL1IU/xSFcaoBW7OwE5fiBkBDfbouFLzQ3n2QMmL5fyGyIddwjrAJ6Kyz3?=
 =?us-ascii?Q?NXhP/zngqQTVuU1NN/uvO0IH9Y8uccLSNTXVi/la01QFZj1G9dIiVZZDEhVZ?=
 =?us-ascii?Q?g288fvC2XkbMic6hS6FQ7UNTwD68Vdl7WPIqJiizESXByYbb72/HEY7vFoVT?=
 =?us-ascii?Q?bTdKNcMMaPFqunUjvaOdsAryxsWTv4J8tZvDc/P+r0BTh/5Rncwy5qREqqzi?=
 =?us-ascii?Q?UW3dTpHkdWnSNeLKK9wLXKMe2HAzxOivWCbWkPnZnqmTjalevCXov6b8X4p8?=
 =?us-ascii?Q?DCF63mGtuFUHZHWfFGCUo8rQ+663m1YnRGi/S2GXkEqs5M7F3p1kqm5RUnRX?=
 =?us-ascii?Q?fx44srZpPwSc2OL/42CbJnavNQo44N0RO8GO8jeGK7KyfyFkBrbc/LETcEM7?=
 =?us-ascii?Q?WieESOWTP6LCNscyeQ9Be461dSuCCsUrlNLzfzImzK/WNSQiLCCYMjwZHp2v?=
 =?us-ascii?Q?9mE9SfCRDdiAsNkArySzLXq7J82Nri26tmCHkaI+ZYPVlPUlool6D2xky5+O?=
 =?us-ascii?Q?yQqj0dMZ/TLOdypX4AM17UiqGShvxHKuqWidM7Djr9nBDgIifZBlAW2McoNF?=
 =?us-ascii?Q?922UUraNRALAXHI9etKVSu64bXG6qjIOM7SRNTtlYdzBnahYiwU5wRWQu4eQ?=
 =?us-ascii?Q?z5DDr5zonkfcm2Ok1+tZ1YJ64rTiaa3cmbnuEmFhdUzdRSgStdrSAFzlBpYm?=
 =?us-ascii?Q?LsCOeuHCCfXhrP5gcXJ3sxhB3TMKbkQe05URQyJMcaxzaZDHnrmRWtz8DqsO?=
 =?us-ascii?Q?vQbbMcpxLdsE/UNSblQGydUq2fcTfDtubzxhDxRS83yaR72DVFwCmFm76SDt?=
 =?us-ascii?Q?ml8USWkPoCnE1+AgXD8BPfoRbmf7/2GkjgzhyzR0dgwpCN5SCV72F6+PGEOX?=
 =?us-ascii?Q?qDB2z18ftaWFnRsTaHWPrwP96Vdj06aKkrh1olM8wuHfLEWY9YHwtkh5CqoC?=
 =?us-ascii?Q?twOtOf5tE6DzF8CL/KnJAKMzg+WHfs8f237uJ1x7QbxVpFZo7DF+fedce1f3?=
 =?us-ascii?Q?6wyNBXq6R9rZT4DmFugkYoe/zV+Hr1KdO8I5GL6NMmsJx9l1JwUVIc6mo6aD?=
 =?us-ascii?Q?4YhVcsUfAsZB4AHx0P9GHhFF1Z1+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?an+pQiLD2JVKYGi4cpHPzKEzJ1qXjjUSB3ik3g0Lyele0KOOFFv6DF6Wtlgl?=
 =?us-ascii?Q?fyA9CrTyCmUZocqmOUDB14dwQVNnUtjlD59Uy/pN/9YPsK3qfctFVv2QKEW7?=
 =?us-ascii?Q?Mgc0kPwl7IVX/+uFoNLTo1XLqgzIzivIft/5dY9/MFIRz01kqtWkU+36T5ti?=
 =?us-ascii?Q?wVdZs9HvWPXb3LGTmS+6mTnsPByNIgG0m9Gn/4kCIrkt90D3vpcEz1lANFT4?=
 =?us-ascii?Q?ooDnK8sVRuVVuUX+fiyowfgloWGH2CYCgZZnyj2O5APhcUd76/DxNwd4EGWv?=
 =?us-ascii?Q?X19c4EVZbMozgLogGkc6tD+3oLUeSKXXX8X3Auzky3GE3S8IUi4cfbmjKtlG?=
 =?us-ascii?Q?bl35PZoMfGELYO4BsC60YFfXoAqLU7ttMfl/md164r1hH127OoTN7nxk/e1t?=
 =?us-ascii?Q?2fvVvYL5vZZ09GaEpE1OLbV6vUsXde02Mv14eJnZg8BE7xadpfiHDqhP8WHM?=
 =?us-ascii?Q?M8PC8EglGthTUSAdOvcJDKjfW13URBXEGBPDi8D9sNTRFTbVs+27uAtK6Y6m?=
 =?us-ascii?Q?Oh635SUUbddqrStckRBaUFgQxBK5En5IdJ9+meTYk0tpXxu0ci+MI8udBiuK?=
 =?us-ascii?Q?Dl/VWYxFcxrp6cS528xwig/rCMQcoEBocFOLnGEpvwgTxL8hDbIFcPVhUZj0?=
 =?us-ascii?Q?17chSq5IXrF8X9XPG2WaVRbUFzK3HtHOcNT28d6VFx1IJ2af+EDr3XaPONMu?=
 =?us-ascii?Q?pCleEGwFRJjYrUw00mzx2b/WjbqGXAlJoT7EiSUEU5fAP4QIBj/PChHowLz1?=
 =?us-ascii?Q?6kEfGQhSPtwYZAn47dfZpQmLfFwc9iNLcaP1qYhquYN1SBfgzysJduFAaOL5?=
 =?us-ascii?Q?SyBKNdtzAXJ0B+/VznAQkH+vCZJW11A9/f3E3KR1kquxlQbgcgu0vQmRDlJ2?=
 =?us-ascii?Q?Y09SGp0CKQA+9MF3aEfy/dl9qzTccyC7VfC7Zk1vKI0f82TTra+FCXl+cQnj?=
 =?us-ascii?Q?GxyoxV1zVTkxQpVHrXccwcbMG3YoZWf978gkdzwLYofdKxEHX+H1VFAe7sCj?=
 =?us-ascii?Q?LcWnTNn2U6k7DcEkRUe0Oof5DAribBvvXMrfxkAVnxYZgoZeVuixjUIxjzHJ?=
 =?us-ascii?Q?o5FSSsyHe+FWY1oRqDBu2zB7F+UJ/bD8/rO1KzSAfj8Na7FWSSp0NFau4kXq?=
 =?us-ascii?Q?2RhFrCACgTnigKeXHcQs4tsIaNvuNAoGmvKJwY+kR+9ZtA6Hhq/Vshg0qkdB?=
 =?us-ascii?Q?/GrZJoFaSxG2YNSROVWqyNr7NOScketwHOCwOrcALrpvH6gvXYg//r5vYcCZ?=
 =?us-ascii?Q?RWn9loMIhojdQzZ4+AQEpN4Qharh9PPTD5mUME0ft4msng0FnO8OnV2EBgXI?=
 =?us-ascii?Q?YdrgaYRxnQ4PRjaDUWm4fMMfmMr4FVDvt4jbGCW+ySCs8yiCDOqcPLgkN2oV?=
 =?us-ascii?Q?rhDYHTSyqKAq839gCIG0VoNRc/Rtu5mEIyzeWV694O64fLHTjfZbnlrHEBZA?=
 =?us-ascii?Q?9IF2hlrdAjdYYli+agAmU0jIQtnPU/Xkp5L9ufdLNbfkFuiIYf4kvhnS5Tk1?=
 =?us-ascii?Q?LQXa6i7UvrZuFf/dgHdWO/8LxNSd/9kBvhO/Edjd9by5ouxrK5pwr2R/pyl1?=
 =?us-ascii?Q?6bei0J1HDRH9mYdUKafKWDdc/yYKJfQHeq6kvDPo2z3JXF8fb3rUZt3sQttP?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ba09ec-25fb-41f3-a9c3-08dd6cda3cfb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 02:51:14.0752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiL6aTx6v19pmQcG7ijt8W4t719UCNsNnsJgCZmS/tLOsjske8NustgkhEhvhulxyzCe4K0JM646KXYnQcV8IOEOPyLDJaTz29HE5z83SKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9059
X-OriginatorOrg: intel.com

Yuquan Wang wrote:
> On Wed, Mar 26, 2025 at 08:53:14AM -0400, Gregory Price wrote:
> > On Wed, Mar 26, 2025 at 05:28:00PM +0800, Yuquan Wang wrote:
> > > > 
> > > > Notice at both the root and the host bridge, the Interleave Ways is 2.
> > > > There are two targets at each level.  The host bridge has a granularity
> > > > of 512 to capture its parent's ways and granularity (`2*256`).
> > > > 
> > > > Each decoder is programmed with the total number of targets (4) and the
> > > > overall granularity (256B).
> > > >
> > > 
> > > Sorry, I tried to set this topology on Qemu Virt and used:
> > > "cxl create-region -d decoder0.0 -t ram -m mem0,mem1,mem2,mem3"
> > > 
> > > but it failed with:
> > > "cxl region: validate_ways: Interleave ways 2 is less than number of memdevs specified: 4"
> > > 
> > > It seems like the CFMWs IW should be 4?
> > >
> > 
> > It has been a while since i've interacted with QEMU's interleave stuff,
> > but IIRC (at least back when I was working on it) most configurations
> > had 1 device per host bridge - in which case the CFMWS IW should be 4
> > with each of the host bridges described in it.
> > 
> > I'm not sure you can do multiple devices per host bridge without a
> > switch setup.
> >
> Qemu counld add 'cxl-rp' under a cxl host bridge. Below is my qemu
> command:
> 
> -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
> -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
> -device cxl-type3,bus=root_port0,volatile-memdev=mem2,id=cxl-mem1 \
> -device cxl-type3,bus=root_port1,volatile-memdev=mem3,id=cxl-mem2 \
> -device pxb-cxl,bus_nr=20,bus=pcie.0,id=cxl.2 \
> -device cxl-rp,port=2,bus=cxl.2,id=root_port2,chassis=0,slot=2 \
> -device cxl-rp,port=3,bus=cxl.2,id=root_port3,chassis=0,slot=3 \
> -device cxl-type3,bus=root_port2,volatile-memdev=mem4,id=cxl-mem3 \
> -device cxl-type3,bus=root_port3,volatile-memdev=mem5,id=cxl-mem4 \
> -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.targets.1=cxl.2,cxl-fmw.0.size=2G \
> 
> My lspci shows:
> 
> -+-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
>  |           +-01.0  Red Hat, Inc. Virtio network device
>  |           +-02.0  Red Hat, Inc. Virtio block device
>  |           +-03.0  Red Hat, Inc. QEMU PCIe Expander bridge
>  |           \-04.0  Red Hat, Inc. QEMU PCIe Expander bridge
>  +-[0000:0c]-+-00.0-[0d]----00.0  Intel Corporation Device 0d93 (CXL)
>  |           \-01.0-[0e]----00.0  Intel Corporation Device 0d93 (CXL)
>  \-[0000:14]-+-00.0-[15]----00.0  Intel Corporation Device 0d93 (CXL)
>              \-01.0-[16]----00.0  Intel Corporation Device 0d93 (CXL)
> 
> My cxl list shows:
> [
>   {
>     "memdev":"mem1",
>     "ram_size":268435456,
>     "serial":0,
>     "host":"0000:15:00.0"
>   },
>   {
>     "memdev":"mem0",
>     "ram_size":268435456,
>     "serial":0,
>     "host":"0000:16:00.0"
>   },
>   {
>     "memdev":"mem2",
>     "ram_size":268435456,
>     "serial":0,
>     "host":"0000:0e:00.0"
>   },
>   {
>     "memdev":"mem3",
>     "ram_size":268435456,
>     "serial":0,
>     "host":"0000:0d:00.0"
>   }
> ]
> 
> Then:
> 
> # cxl create-region -d decoder0.0 -t ram -m mem0,mem1,mem2,mem3
> cxl region: validate_ways: Interleave ways 2 is less than number of memdevs specified: 4
> cxl region: cmd_create_region: created 0 regions
> 
> This case confuesed me :(

What is the output of:

    cxl list -M -d decoder0.0

...my expectation is that it only finds 2 potential endpoint devices
that are mapped by that decoder, I.e. QEMU did not produce a CFMWS that
interleaves the 2 host-bridges.

The error message could be improved to clarify that only endpoints
mapped by the given decoder are candidates to be members of a region.
