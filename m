Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F601E0DCA;
	Mon, 10 Feb 2025 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739187513; cv=fail; b=pcDLLAGYiD+0i0Vg3Jn9cSv9pn8TPIYxrhJbuhgTYQyZp5W3Gq9nWEMt1QeDfscphZUH1nhoml55ZORxKK7fp/M38nY/LDTJdCwqdZxSooWSxsmUvArFyHcRYdHC6tzALPaERdQCvjMRJDLGuM0MLVkyrOCv7AeOC9R2S/evozU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739187513; c=relaxed/simple;
	bh=vmHm1EYSl7mM9J1fnL4Hlqv3F+UYLRHJvQhUiskQSo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YrzKL34+CAy8PM+tUV3yxsN9+dnHjfWpcAWT0oHQhDsG62LX1xv4kkg/11ppNZGGzh7FameqsGlBJL1s2kv8K0oheXLe7TRh1+HRnh/D7U1ecPtPHmPAU0wAZKuvVj2CbFOpJdw49beVTx9DDVoDehAdtpU7dOPnmvIn0kEI9/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nBFfFdbb; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nBFfFdbb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4NOqT/FheSED9t4KTtVzWtPaawpjn0QnIsHhsRngk9Jkj1XtEuKN01EbzG6Z7CdL7EQE6v9vsmhuNlrCdb6PhgB4pX+nnwe6873LwkG9Iep6Rf719A7BzAeb+L7u5XJFS9X9AcU2R6wy8aDoT0m4C6MrbeVKqXEbMBa9kZTkyyl2ivsP4V8T27n/Gioz/r/434jz0amznoacmecB0emfc7COEtYx2lY610Ig6zcEmwKdCT7TtRudK1L4SK3y0h2Ownt0i7KcAyH4706o8QdlKJ83lTvQD5tVfhpioZdSipOYUJQFYrqCymrh6Pn0Wdx70ipeYwEgshZDZnY5re0zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgxHXj6Gfng/YLsfxSWEvO7RSxAl10vyz8abynsulRw=;
 b=LaEYAftydz7usuLCi6MDANGLiQFXEgzhHhmlA35plD6c2v59bvP325tTHch0eYwb+3gjBc5KIfuKI4QPZQEeuSlsHVOMV1AYjyU+b2B/9/xmJSLj7ty5JUH6RnpPToAfIclJURJ8yEWdbwtTsS5j/Tjtd5OjLwoIG4C7ynQ30VzNIYLFpTmDJv5EZ1aiLKWlKrL9mNDAHn7c1T7ZVeIXjjXAbeIGqyOH0sbOOEXhLqlnS0Rq7z7wlT9u6IugfZZIhZz3TZ9BPJCVCVBbQ7Vu0OLbKYNiXI9+kt6ICTWLuYas/pH2g3jx8xo0fGHt2z7bSYLvROZlIFrplUURQEeaIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgxHXj6Gfng/YLsfxSWEvO7RSxAl10vyz8abynsulRw=;
 b=nBFfFdbbisMiGM4Gj7u2PPl0VUwUaxrmGNX+0TjXc/msBxiA7QxD3dLdg0eVpk71LH2J9iJi8kjOPEhuVYzH6/O5HNt4iyVS4+oJwtl6QzP3pgYJCwjZ5fJwGJuJoJ4nMtJGq8zBWWN9OVpmRcjpswjtS084CKzfUNzqqGRgRVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 11:38:27 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 11:38:27 +0000
Date: Mon, 10 Feb 2025 12:38:21 +0100
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 05/18] cxl: Introduce parent_port_of() helper
Message-ID: <Z6nlLZ8wyIPUay3f@rric.localdomain>
References: <20250207153753.418849-1-rrichter@amd.com>
 <20250207153753.418849-6-rrichter@amd.com>
 <Z6aSW8N4yULozrDE@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6aSW8N4yULozrDE@aschofie-mobl2.lan>
X-ClientProxiedBy: FR3P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::20) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: 48bd7416-d002-4b69-f288-08dd49c76f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gCIR3wW9LIHOxKM5ilQZfiZjQz1fC2Ta1GxuJN78en75UMjY4gm4d5QJjkU6?=
 =?us-ascii?Q?L3ZimfkxHI75QyT3z6hmLAkKLooKLVMUmK6bSQDZLYRUQZ/6C9mIRwCj97ne?=
 =?us-ascii?Q?Fm1M+Vf1kKPsPSKssVQkMudf2SAerZh9uG7kQjzeKAo/mW+w2IDwGfj9OmUB?=
 =?us-ascii?Q?7EZU8wEcn+pSVJcu9WGf2bcifnzLyEgSxSIZaCravC4xtLJVOvyi3NySs9U8?=
 =?us-ascii?Q?rhjIFH1/gVrfB05aPy+EjBttX8sYm0mtug6X8xnSmDaAMoyrkXkbNScJMSVo?=
 =?us-ascii?Q?Cfug8T3Tjz4PNsNwnUQ92+5oyFxlL8REPXRmWjoo1H/wWQkz+nfR9+0unAR6?=
 =?us-ascii?Q?Z/rSP3e02cDNY12qptAvy3WZJkeeXAE3U+BshSGBLU7MtF/kEK8Y6BXxjfo/?=
 =?us-ascii?Q?EhmfQqqKJeaKeyJt29Fu/hMA1WYte08CuPBglTT7zNTb1DXjReJDb2JYmEHd?=
 =?us-ascii?Q?EpNqzG/E7t9YoeB1bgzL6xw4BhJJ7LBKdZbefN1mj6uL2B/+mcTLP5lcgKT4?=
 =?us-ascii?Q?g23TjC+ECYREXlP/pkxW3UgvB/pYQRQbgPkpoWKB+P7Ks5nPBfbWOAsIg3Oo?=
 =?us-ascii?Q?YtCPoLc7os4IMPclg+SDgk34y4XI/pezPdilCzR5p+TkYoaMW22DlAnlw8b9?=
 =?us-ascii?Q?uowgnOYeTgnL8gyFVAAQxNTF1yku1crlHzxK79IrwC+FL699JSn8crIZb5f+?=
 =?us-ascii?Q?pyMi/c3xGhzM2FC0fNmnzXsm1IHM6UIpQCugdUhEN43BZjFDdncJoZRSO4Ko?=
 =?us-ascii?Q?KNbGb6a40/hpXJVJHjX5MTIlw75AJh/3+D0fi3OmQNNv+Xv9Oeabl0OJQPtP?=
 =?us-ascii?Q?/HVjtCrOdOfkfWftk/sVtaGKjMPadJ2FMVyUr2NSPnzTy6Q4+TcYBgzBfidP?=
 =?us-ascii?Q?Pgp7EWlGeji8P18bki73lp/HNBB3LwHcrN05AK621EifF2i/4FERqoVwm3KU?=
 =?us-ascii?Q?70IP9+lydtfNUB4wcPN79ZrxAe66tqXPdKWG7/rbk6gG7wWyJVLcNbrSGCtJ?=
 =?us-ascii?Q?+tCD3RGlLlX+uKqFDTXn8HSIcZa8C3qL/Eif5IG6j81T+53lFk0e6ySdbZEv?=
 =?us-ascii?Q?ArntcFMxUSAKQhGxYwT5DDfW0kCQDDfwFsHrJ8j1HUJK0EA/lqFhuI8XFjVR?=
 =?us-ascii?Q?erPBF6B4/GHGe3E3QL7jDtnNDnBDc5OJdCEAGN6shORRjyn4w5R5rtm9jwpO?=
 =?us-ascii?Q?5hJitSBVxrZEqL3M+dS6e+c5SdCrNaFKb1Tv1ZA9CFklTsaoqJKWItxGlHTR?=
 =?us-ascii?Q?8dp/NUWmE9f+NtfuqTQzA5IV7il7bGGMiCH6/6X15G6o+ih81iaRpYAGzMdU?=
 =?us-ascii?Q?/KZ9A0Zn+a8o9nbpruFrXfr4cpxdBkbi1M2IsP2yH4GGjcW7tG+oVuRkQblm?=
 =?us-ascii?Q?vN4H8QF8ix91ZbOckApF8tlLYqt9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L2FfmcJZZczeRzITOtdqJ/2ANuJ0/iEiaOMUH1G6Gcx2IpGnwtKTfARUwzQ2?=
 =?us-ascii?Q?M3UwLhW1z0ASt1o++RfrB2RhCQ/v9y5c1vP4sR57UzdDcLIktvg/7M1X8jNH?=
 =?us-ascii?Q?2/eYpR/zxCkYQQc9yXg9ijHEvVKF2TUpWjli4F1rltEL7BxMiZ12xSKLX3SB?=
 =?us-ascii?Q?KDBZ34h820dHEIVyeGtRQUCjD929L5smYX/03FZK8K62BicsmuC1RASr7C0t?=
 =?us-ascii?Q?RwrZ5XYVe0cqw8a9CqyZnUrWbRdwkR/2+mud7ZlPflNCeXw6FMBFGxifBpkP?=
 =?us-ascii?Q?p7Zyvf/gq6o/P6yar0bJJYAVsP28MJFypN0ZvM9O25vMKmBn6/tKlm84maAp?=
 =?us-ascii?Q?4puVA0Vuia24Vl/s6rrM+Pc3EjpZVXgRLB16Ex2urDPAerzeSiAmgpDzTsQb?=
 =?us-ascii?Q?7lhZfD7OWPdRJtRZxBvKw4lK728apLPkqgUOp8DYf7CMBRHzVsQlh0ddjMQ/?=
 =?us-ascii?Q?56BnOKvckif/EgF13reWTItMGLfjAnYRFQo8/ZS21UAqOl1tpJcgkR6g7/q/?=
 =?us-ascii?Q?ZRZsjz/a3/Ak8wG4lhxEjS/fLbOmS9C7BnZqXOXxbohs7MftbwMZo2hl9cmB?=
 =?us-ascii?Q?wCcuY1UbaM3m3CjpUN99OCv61S2gjic+Eav2IRNekKUwoQsh6IcdocWuB6rq?=
 =?us-ascii?Q?yB1ERvZ8P+01zcIsThziU+K8wQSikl8W01DHZz5I+895uV+4ZxushzgXVKT8?=
 =?us-ascii?Q?PiI+uCVcO099gbz+VVZglZpLBt+UEOyCPzU3bwt7jTq8+yBXp8yHc2gqibmh?=
 =?us-ascii?Q?A+J2OmLRnrd10Rdr4ns2G5Uy4z8rLeyblonZYqqGAoRoMWfPVr0pH7w8k5dz?=
 =?us-ascii?Q?rn97T00YHKtVMIL5Xlbun9nlfRIO1miwP2m63bgOyRWrCdMI3YDwr3fP4AlQ?=
 =?us-ascii?Q?DlJwqPHt1VUgfoYXVrQaiyJ74kLXbWyd+Lh0vLpDuOX1czhBUnfzwgA1v9Om?=
 =?us-ascii?Q?WAGu/5myDzRT6jR2pcM2yyaDhiZK8VkvCqdanmzWJl6acfjXAViEJYypE8Mo?=
 =?us-ascii?Q?1jpIUNysP9DBGk/RP8mBYv9F+DnVJsb9ypiRydlyM4qAdhueAZcCCqOKvYz6?=
 =?us-ascii?Q?Yj3ro2m/cDIDVpvmmxnhQuKiq9+5Wd4LPIYqbTwaSQASBemRe0rKrh4qlL7y?=
 =?us-ascii?Q?BF9KpOgsWrLkcu1DFUtmAX0TC4/yiX5VMh7DS1Uec9X1zp4hudsHrzWkpfCU?=
 =?us-ascii?Q?fF6PilIgh4i02N5RP+pPCC1bGm5tstJ4ibX8ICp/LebOPYFGLF458RTCn/or?=
 =?us-ascii?Q?tD3W0wJBWNYEEau3ITDMXlXRiWJQ9l+hfMlv7kHYQBWp2xli/BmyHxsFBroM?=
 =?us-ascii?Q?h6hXdZnqnsPyn08rBQJ5IulVjPxzyMkDWwVUV3vzRhKb9TUpL4ucmfR6u5w0?=
 =?us-ascii?Q?UUq/gxiKmj6vNgDrwiHylhVtdhB6is4MapH0jXfidZOYA3RPw1I55qaGCAIF?=
 =?us-ascii?Q?iwAxlNberK+e5vBQDpPpTLRBF5I4/FPkQdhEp//9Amr5kTfXJBh2apIbeEoX?=
 =?us-ascii?Q?RweA8Xur1rf/phvBlwKyrnOUVQB7QdcW1cHMYrY0J/QuM7RZkWx5ngR3+EJX?=
 =?us-ascii?Q?Iv0whu5wTN2JkoP9M778JaWMUvdenfVyZoCBEWoo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bd7416-d002-4b69-f288-08dd49c76f4d
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 11:38:27.2530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQ7DVkbNFJZhQc1gO4YP9M8XtGuPzggfjIlrIw5ZugzFDXECWyEMS6hRCdqXKuVc5q3dUnZ6GcaJeNfWWHHzrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901

On 07.02.25 15:08:11, Alison Schofield wrote:
> On Fri, Feb 07, 2025 at 04:37:40PM +0100, Robert Richter wrote:
> > Often a parent port must be determined. Introduce the parent_port_of()
> > helper function for this.
> 
> Would this be simpler with less touchpoints:
> 
> Make next_port() available to the port driver by moving it from
> region.c to port.c. Note that simply exporting from the region
> driver is not an option since region driver is not guaranteed
> to be configured.
> 
> (Basically I'm suggesting keep the name and touch region.c less)

As long as next_port() is used in a local context the function name
works well as its direct use is visible. But when exporting it, the
name "next_port()" is not very specific. So I renamed it to better
describe the function similar to other helpers like this. Changes for
the rename are just 2 lines in region.c.

The helper is only used in the core module, there is no strict need to
export it from there. Anyway, I implemented it the same way as the
to_cxl_port() helper and it can be used outside of core too. This does
not introduce more code (except for the EXPORT_SYMBOL_NS_GPL line).

Thus, I rather would like to keep the patch as it is.

Thanks for review,

-Robert

> 
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Reviewed-by: Gregory Price <gourry@gourry.net>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
