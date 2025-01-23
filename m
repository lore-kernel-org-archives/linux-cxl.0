Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49955234
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 03:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737601884; cv=fail; b=lCxwAxxs2dKSDmbOnmhLcZLXZnUOfLKR2pUh5Edlxznlxe8eyNQP6gA96RWqAY6+Ij1gbOc22i7Axl+ggEkZXPQnQ8zyR0sGHC+YQ9FY1A+e0gce4xOgNC6h7+ROsTqb4AtroB+BAF+f2J5SLjHWHzeiT5r+F+COaAlqXr9ODmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737601884; c=relaxed/simple;
	bh=oEDsxLdYhzXUDcG/Hp9hgA7EsagwbCVFtgul7b/cRbg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S0Z8amcr9rbqEqqzK0JQEdvoBQp2BcvGOyIPj8oAglnwYm5Mk8skXqVl1Wwbe6oHdWwHdLSJVcDwehn6OS8t4bIDJOTsBpeV0eZNb5s6fQH6D3/aUDtP7ySDQ5JV21PPFhwnVcloOOtQT0A0TaRv/VB9LgpnCk3M/H6i2Z4Pm4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WGQz9OAe; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WGQz9OAe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737601882; x=1769137882;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oEDsxLdYhzXUDcG/Hp9hgA7EsagwbCVFtgul7b/cRbg=;
  b=WGQz9OAepgtqTd3g6DKm+yQAjm+9sBcPGDguSTk4ErgeAn70JQl7i7NP
   zJNZKgcsDfbtKHnjeJdrRpZhp4Od6WaRol0yM4gOf/GGDidhDydjwcauK
   BlPuZwOOd2CnAXiVeSUuqxgfy9+gclTVaZT7p3udsnnyGvJAqJS07EVdQ
   INixMMpCyGt/bYrUcjXLpD/bA//lZ4eDdQOoiJEr7UxDOzyW0VvqQD4n0
   3WHg7rMiDQwMxiGN6n+MATvOiU688NmOCRLJRm7lgB3WYauOkoLK3DK1A
   6Gnqb2NydsSycIDUhQyrAw4v1d2AVbF7YtomnBxR/zK72T/t6/Qbj2MCG
   A==;
X-CSE-ConnectionGUID: RmtvK3+SQju3nXKzXWxzWQ==
X-CSE-MsgGUID: RUvqkl5iTCSNZU8IRifaYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="49502737"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="49502737"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 19:11:21 -0800
X-CSE-ConnectionGUID: c0L8QoDIQP2y8aoZR851Eg==
X-CSE-MsgGUID: mrzVAQ48QN+wgwagpb0K7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="138187593"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 19:11:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 19:11:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 19:11:21 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 19:11:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgFhNroNrb/v+xSbn2TrdcRxHKgTCJEkcUBL1ySz62u8gJjxbujsV3r9nOE9ttyt0RiWGRvQImmTeOWvhjgb2UQnA/NR0IkpAzqc+5K9IomakSCsxuqt8OzP/caObwJbwYUBLLQ8xewgRRQ2iYG1UVCGWokXE8j6C/BN0nngSXntteI5vlmJCffL5oYUVJhWhLE7f00cp7+qQYGK1i9by2s9WslQWmbam8Ncgh6LWmfPuX3SBPJpW46K23KCHjgUB/I/a3J6ixkauRMCfKtS/OujRFfnZAvasaNGYyads365uA3RhlffADZwkpTJeUZQ0xH8Wgy8g5XaSfUBHOiWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IcXQ2cwYEl1hFqeJyaYVX3hHMN+9u2OWL7rqaOWDfA=;
 b=vV1D45XByCZ+i6C3DIqwKXPtgu8TZEMDtK6kuxk+RWV9ygmAPuamy4tYHpKoJLaU7JY7f+UrG4eBGb2y1vgodqaseaapJXO1c3/8B/59jPXUyKaRBTyq5uEJDdS6cMCJ3gniZMaRaUy2hCt1P9+lFLfkYHtfB2XSBP1kM5B7TCLMAj7NyZ+nan230bDNBuTkUO/Zfy9Kcm+6tOmwJzAwAUER6VcxMJ4TO3DdzpYiDcdmw+DG/kka6V/5HAJF93F92wlUlAAH6bAssNR3MxuVhs3ezVkOSCxw5yYQxCP1z8wf8ekQMb4s4NQI0hfQJZQosFkmg8RVbJ+WN+HpqT8BCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.22; Thu, 23 Jan 2025 03:10:45 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 03:10:44 +0000
Date: Wed, 22 Jan 2025 21:10:40 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
	Ira Weiny <ira.weiny@intel.com>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 3/5] cxl: Introduce 'struct cxl_dpa_partition' and
 'struct cxl_range_info'
Message-ID: <6791b3308b5f9_55840294ad@iweiny-mobl.notmuch>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753636727.3849855.464861650807086965.stgit@dwillia2-xfh.jf.intel.com>
 <67910657b96a5_1eafc2947c@iweiny-mobl.notmuch>
 <67917029386b5_20fa2942a@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <67917029386b5_20fa2942a@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:303:8e::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM3PR11MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: f30ecdbd-7936-4cbe-ec48-08dd3b5b86ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/BMXQ392kBJUJyBWtYDqmRViidnh/2w/bRCf5zJUau6TJRNGvi1k6NnvwFM+?=
 =?us-ascii?Q?Agr9uTpJkxJM7/exy5ZeAjCNiAgr7BIwOfpkuk0pHvb2MLthkB0ZQ723qFOI?=
 =?us-ascii?Q?zkCjLZFL/wbHguoKBTtVT8oY1jNHGx7jy5DdoZRKFsbbqCSKbnxK27LA1GvL?=
 =?us-ascii?Q?ZuLPdN/SKsnyBo6GFyE/TznsDLzHjenR0H6RUalPYzenmzq8dC60Z/SpJY82?=
 =?us-ascii?Q?rrt8d6m7MoCBDAu8P+me9ywMnd89LHoyn5xeKIQ6VFheP9dV8AldCfg7hXw8?=
 =?us-ascii?Q?jSI32nq3ybDNkeeVBdX+P1CMwSFtmzF8iLX7KloHPsiczL1H1BFLUDed/spH?=
 =?us-ascii?Q?7LnK+SMUvG9EHmV7YUQVQjKce1y6wnDcW6rtIflwSDCyC4biY6T7TbS56gfS?=
 =?us-ascii?Q?VbTRRNZf2AL7WSEjn2Wpemk39R0HciaiR1lWTDyZcAoLDlGbPMa9OTLvBnpl?=
 =?us-ascii?Q?9qUVaVB3Kx3maai8XM8pKitDfoDhMUtgjyOkFcvs1BqMHfsaaeckMDe8oCEK?=
 =?us-ascii?Q?3XYDwyQpIj3Ar8zQmvHV1ExpYuc9vwL509/JAsS5VWT9/+G5WGqH+bA23v8W?=
 =?us-ascii?Q?50RTgBrJOudd8cooHtgWb5vgUbZysEeSoIOqyfspkLzTeNbGNyNOITJp4Hqi?=
 =?us-ascii?Q?Wer+VOPaqYvd4mbqciVV5JcbF7DOmyZEOjNk55zdChXhKccxrA/J89rtZwFu?=
 =?us-ascii?Q?8wswtyIgZ06lITuEo6i+b8P9n8nAYk9yRz145JFBmqM2O4QlWFbMC6Ry4BDP?=
 =?us-ascii?Q?DiOdFT4a4pMc+zNJVtKJY0NbbsQWjln0+VX00XiYOHopglHwmnB39fZr4P5C?=
 =?us-ascii?Q?wW1ryJ4Eq45Dfk1y2lByWtTww7ZUgN3isJiVUnkrFG9hNASlQBv7wQZoqslB?=
 =?us-ascii?Q?qmcDA493ER8ih2oAky3u9syOe7LExQqPPxbFfxnd4PBzaKO5I2yw4A2297ZB?=
 =?us-ascii?Q?Za4pMHiAQy6TuwjGk572UIKQgEAnzN8RDSVbGoietTLgeoSrF1knlLiykGdP?=
 =?us-ascii?Q?zLMhiG0o5k0fdbWJpiHdNHHdBAT4yhWlP3L09UP/Xqaaj+96IDTZe2eTxoHd?=
 =?us-ascii?Q?BwQZvFdxy5M0oktXIK1HHFGSy7QelCiWeC4ccr2/HDQzmS0ccm3A/fLLKjpC?=
 =?us-ascii?Q?5p9JQJjPuvWDqzFN/Yq0zt63npOFohxVRBcfyZiwH5Z69tSw4xqPs2EnwG5P?=
 =?us-ascii?Q?u3p4S0rNA9HaU4Jd0BjwfQmLUmOGdNvT8jusJF/7Z1ibdL/wyEvwlPWheQCt?=
 =?us-ascii?Q?bnyZ/+MJiMOeKWZKhoCWGR961V+ut7Xu+wGDxfetlBqBPh2DlsPCuAv3Llnr?=
 =?us-ascii?Q?y2BSb/IFOWBZofgryTHHALi507Rv0wXAEK1UUTaVFoH1S6e+U8T/Z9GN4zH2?=
 =?us-ascii?Q?rxdO1Xs0huvdIQx7/VCOMWoydzep?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XGXnh5FeaaO0fhTOiWmP8aQaSbHiDYanhVH8gZNnOuAGBY+lQ2lJ33jiI347?=
 =?us-ascii?Q?FHbBoH9WW9tLiHLHeQNy/U1DwxULqI+PTfzKPiRl5ZRgzPjJ217I5OmGohmu?=
 =?us-ascii?Q?1Zl1FeYK0muIOwPaF4somnpmh4jOmvAkV92DQuxD1wcnvP4YIe2d1AN9n+42?=
 =?us-ascii?Q?ofP18ELiZPM8i2nPex7b2YERSrm6lQEe00OZOsAxhVz6/LzekY/D6+BHJHZf?=
 =?us-ascii?Q?rm/oyb47dmi3cXyYIjDtSp4axw5FA6UsaLXj3EW8OlFAA/O3/+e+GnPmPJYT?=
 =?us-ascii?Q?f6E1pjFEzEXatfcFMYkIzzSzUycU1ctdx4gYTyyeheqPHrr4WvGvsQhR3wCS?=
 =?us-ascii?Q?OvZIth28DlA/WgbKCn7S2JRPillNxIem5+4zIIu88C/dZHnRcVIpZhuwxKkt?=
 =?us-ascii?Q?/nek0cLkcMSN/sFClweybtaXx3q0RH9PYuntVSR/1BPxwEbLEhmrDM56H0wM?=
 =?us-ascii?Q?wTruAnC+cPUEnlqPiOwDWpmvH4M121HpQ+DjzqhWpNld2XZibwOfJGcZhNfj?=
 =?us-ascii?Q?rBaPoCIG4dO8Ot+HHLdQib76x/oR0xL4J9VQ/i+tAm3+xL/p62opvimlpUeH?=
 =?us-ascii?Q?WqD5mNqZ6AEadAo0AleTtmB3Bwmy3JVWjr4UV0cUCqf8lGMcAbZt06R2wEpC?=
 =?us-ascii?Q?E24UG6rYxfArLXBODDdiZlwunCwVuyC4nl3Dz0j1pFU4GwuN1YXFm/UrqUpZ?=
 =?us-ascii?Q?vBMboxZVkx3mSYFOgWM2Ra8xQt2eXPY/EOyRUHQs6uujH5Y/ON1dx1c6Uw1W?=
 =?us-ascii?Q?qOSrkszgf6YkafFstStjXuyMnLU3gnTVbXdBkkN9qtQkuQtcVvfyDxvUXqbP?=
 =?us-ascii?Q?aiLqm0e/Z9z0DclFj26KzI9Sy2gRP+vrSCHecwW97wDCw6MrtvpScQdBswYf?=
 =?us-ascii?Q?HRwoEYkyY6oJNgjosodzcaOZB2/NGxNUcXhsfGpRMjGjxw220Bni+8cKvrsg?=
 =?us-ascii?Q?G6rGKSD8qx+eKibVlRA63DhgpCSd7GNj8hty92ZJwniTKqYyt4vqqpqt5nT/?=
 =?us-ascii?Q?6pbMwFAeAn9Phlwpf+B1i9jWcxBfNQQGWoJ6SN+OsXr0krQQRjbckvfYvGED?=
 =?us-ascii?Q?D/qoi4F9VmjRBfts7hIxFxsM2o/Zsq6WKoF/uYoh5H9dtu6ZpVU6i8z38eb2?=
 =?us-ascii?Q?MZ45If0iWYJeBCqzKnhVX+B/VgjvZF/JJUOOAcbyfe5S/UmBl6lsOTcFIkrH?=
 =?us-ascii?Q?s95eTZhe4xLyMgUm+BxyNk5aw5SitWS3gDA57hlptL3Pi7S8Zddce1h42z1Y?=
 =?us-ascii?Q?vyGKSNLjRRPH8aYkU8QZGNRxH5urhJYjy/rQVgnhaE7kLlzgPzK4TgCK0Qci?=
 =?us-ascii?Q?K5tpF+/ZiEEILUAZPjKGc0LzpS4Z1rVInmzv6fjplg7Xl6UrF50kwUyyZ/un?=
 =?us-ascii?Q?Nen1ZUwu9aqdftWYWN+/zfz9VMluZ/u32d7Q3Us5ejDyhp7ZIfKLXEcytfqL?=
 =?us-ascii?Q?6JMigTYcSHbWxewSRG2Fl4PWJAgYzDDU6ciQ1LM+TjyMjWYn2DtezA/4SCbb?=
 =?us-ascii?Q?ahKmYt7aRE+LgKoYkPHxJTzDIM13fNfMSeSHW5p6b1WUEprXqGHKaVLVfnXk?=
 =?us-ascii?Q?qbSc5VDlIF1NOHlr5qPOKDyz+vWoB7O5WGWDoTpZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f30ecdbd-7936-4cbe-ec48-08dd3b5b86ab
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 03:10:44.6524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BC1iNJrH+9tL39hjTXoKC2u8be9Chai3NeKUAcv86qWLqIQHz0fnrqG1y0aKjkG+rvf/hU+NbCUvMEGwc/ekeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8736
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:
> > Dan Williams wrote:
> > 
> > [snip]
> > 
> > > +/* if this fails the caller must destroy @cxlds, there is no recovery */
> > > +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
> > > +{
> > > +	struct device *dev = cxlds->dev;
> > > +
> > > +	guard(rwsem_write)(&cxl_dpa_rwsem);
> > > +
> > > +	if (cxlds->nr_partitions)
> > > +		return -EBUSY;
> > > +
> > > +	if (!info->size || !info->nr_partitions) {
> > > +		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> > > +		cxlds->nr_partitions = 0;
> > > +		return 0;
> > > +	}
> > > +
> > > +	cxlds->dpa_res = DEFINE_RES_MEM(0, info->size);
> > > +
> > > +	for (int i = 0; i < info->nr_partitions; i++) {
> > > +		const struct cxl_dpa_part_info *part = &info->part[i];
> > > +		const char *desc;
> > > +		int rc;
> > > +
> > > +		if (part->mode == CXL_PARTMODE_RAM)
> > > +			desc = "ram";
> > > +		else if (part->mode == CXL_PARTMODE_PMEM)
> > > +			desc = "pmem";
> > > +		else
> > > +			desc = "";
> > 
> > This can be a follow on patch but why not allow devices to name their
> > partitions?
> 
> The proposal in patch5 is that the partition resource name is the
> operation mode. See the changes to mode_show().
> 
> So the name is there for the kernel/user ABI to tie the decoder's
> assigned partition to an operation mode.
> 
> Now, what may need to happen is that the partitions and their modes get
> exported in case userspace needs to know that allocating a decoder to
> "dynamic ram" before it allocates a decoder to "ram" implies that future
> attempts to allocate "ram" will fail. That may not need to include the
> actual partition indices, just an ordering of operation modes.

I'm not buying the 'dynamic ram' partition type just yet.  What evidence
do we have that a device will not have 2 dynamic ram partitions?

Further, in all our discussions on the use cases of DCD no one has
mentioned a need for the partition attributes to be communicated to the
user.

I'm starting to think this is better left to the user with the export of
the attributes of each partition to the user.

But that has little to do with this patch now.

> 
> So far we have been saved from needing such a thing as "ram+pmem"
> devices are only an emulation test case, not something where end users
> can get themselves into trouble by doing out-of-order allocations.
> 
> Usually RAM is pre-allocated by BIOS which also limits the possibility
> of the 'skip' code ever being used.
> 
> > > +		cxlds->part[i].perf.qos_class = CXL_QOS_CLASS_INVALID;
> > > +		cxlds->part[i].mode = part->mode;
> > > +		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->part[i].res,
> > > +				 part->range.start, range_len(&part->range),
> > > +				 desc);
> > > +		if (rc)
> > > +			return rc;
> > > +		cxlds->nr_partitions++;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(cxl_dpa_setup);
> > > +
> > >  int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> > >  				resource_size_t base, resource_size_t len,
> > >  				resource_size_t skipped)
> > 
> > [snip]
> > 
> > >  
> > > -static inline struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> > > +
> > > +/* Static RAM is only expected at partition 0. */
> > 
> > Is this because the spec requires RAM first and the partition array must
> > remain in DPA order?
> 
> Yes.
> 
> > This could be in a follow on patch, but unless I'm missing something the
> > partition information must be specified in increasing DPA order.  Perhaps
> > that is accounted for in this series later.
> 
> The partition information is specified in increasing DPA order in these
> patches, so I am missing the concern?

No not missing anything.

Ira
