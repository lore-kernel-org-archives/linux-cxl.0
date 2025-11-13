Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A9F1FFC6D;
	Thu, 13 Nov 2025 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763064314; cv=fail; b=jBP+qHmAI3fJjU7SF9lY/c/g1AVHA8Ig8Bl/ZvMPJZGngzHUKKf2vA0ExawdKSjD7Q8kUUdb/TSgMVmC034l7E2S+CjODFIpMcuc4Xrf7P4pbU4V6GDDpeG0F4jhlQ7FLUAHPWlYysG4ouWzolAuJN0/otY3DonsthhA7ZMjgiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763064314; c=relaxed/simple;
	bh=Cppl3/Q6M69fEFKHJz80//JgqarHF8gGn7Bzxmd4/b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rr12E8CShA84N+9h/O29AbIK3cmBxTFLsF/WTlnR3MzDLxQrIwb5T0EUFvox9NTrfOHmuYoiptrFUiSiYd3Mim+cNhXwAPCDucfkPXdpfRR7NXa0zYsu25ya++iZ3sLfitGkV3kXFTOdC1JGISLSRIh7zoBrtg4OlaR9s/tvPNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=49IfgXJF; arc=fail smtp.client-ip=40.107.209.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="49IfgXJF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2Q0ysZemNIagA5hJXpO3E/NBorD+Yj0udpvBO/42BuwBbQbVIyblOUesYrt7sDoLaNzG6MG3Ucqfy4U7uWTh0OyRmEmAtR9qiXtHkrv1YUDpTpVfRWEbNFXjaIR/HppRFOB9a4U03vUBcpvmvMgAV/Tc8BVrpOCIXNE/sZu1X++bsDnzKGsvi8th56950Jh/ptGYU07Df+A6j12EDQdQs5bErbA9GK4AEL3FRpCyJI/waVT4vR144Q2R33PG/P12y3U7yNPep+4KHKuJe9riPPGPfs7QoeaMq5ArYAdoXbN7twgneYdGezqT/uHvTRnHBfHHgN9KtDv1g8ExkZdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXhkDawDv1xRvXFBrDrDUHKaJn9a9fxurez8O1WI0d4=;
 b=A4HA/54aCYd3xDUdHy6hbdWqH7RsTLXNvUXd2GjQjtTIKkbbkAUS0U9Z6WZNs7I57ONpMisLtTmoAWgH0tBkUp9kbL1hGgKL27EDPM+LvS0anaBS5+ryQ20iObbVDTJqPDNXyLZKxspjclveI2SF2kmOBp3C+KXIpLCB1PC7Gwn4FmVA3IN3F2U4Yez+28d0N9XfPuFD88ENc2nkQoWPSH/cCVcLlhL0hbt3kiU3UhYSgcJgJCAyGqMznIK61DJZI5GMQS6gjHrF415avaGD4TcJUVXOiGOIsghB/lTYT7X4zxxLg5K2K/11zzAuhntrsXH8cBIIQOrxVEB1DmGBag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXhkDawDv1xRvXFBrDrDUHKaJn9a9fxurez8O1WI0d4=;
 b=49IfgXJFop7Ybg19mJFtzEL3kAHTqqc7p5isIqXfIgQLa9QjhtIup9aTjxr14Sy5liKy6p5GC18rsU2i7em7z5Yj2HFSvki7PbnDCaZSPpIluGzimPouLhR1QJjvqWsS90ZWR++6Uj+dB6v5sP5Ab3VIzYy2iDRZhsd9W5+EZwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MN6PR12MB8469.namprd12.prod.outlook.com (2603:10b6:208:46e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Thu, 13 Nov
 2025 20:05:10 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 20:05:10 +0000
Date: Thu, 13 Nov 2025 21:05:37 +0100
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 11/14] cxl/atl: Lock decoders that need address
 translation
Message-ID: <aRY6EaTALW4SvkaW@rric.localdomain>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-12-rrichter@amd.com>
 <ae28560c-ed16-400b-bf3d-86e2cc8617cf@intel.com>
 <aRMx-YYhaouP4LvR@rric.localdomain>
 <6f1eaf10-071c-41ad-bda3-62eb6b1119e9@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f1eaf10-071c-41ad-bda3-62eb6b1119e9@intel.com>
X-ClientProxiedBy: FR2P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::15) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MN6PR12MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: b519bbcd-3ddb-4d67-3c4b-08de22eff2ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OCnRgvVYABZJuPT7suauV9kd6t2ChiWgAl1somZXha9CUetOi9syAGnuzZqE?=
 =?us-ascii?Q?1D0nNpuPF3+pFzyYZjyOef4C05pWTzbP9oZKD+eoaoSO+7835vrkxmavt5wU?=
 =?us-ascii?Q?DHpQbeP63sQ965zBOiTcmzCG5LL8phPNTA/AnFnDl1uhLgIvBSjn+pELEFE3?=
 =?us-ascii?Q?U7lp5RD70siJBMI5yuKO+2zOHM9mpOIscO2YaZKeul1y5syrHE6sqnm95OYP?=
 =?us-ascii?Q?EpeKudg58wwrNsplF9+XChBe6zJokzo5eqkU/4SC67eAGsMoTvZJFFkoKX40?=
 =?us-ascii?Q?AlActKpHjXRb0nGczGvnZ9m4aeKEzlmY8/vZO5ZOWPag2TA0knwepwOLVp1R?=
 =?us-ascii?Q?4D/VprCWJSLD54HF/uHTEKJal/9PC+rbjFQaJk6fciqjF8LMfrojYuY6eb21?=
 =?us-ascii?Q?1qsuxz31AYlIZfZFr9H0K6SNOGju9dkrnSPut0paGTL85VUO4uZcN3aM2mDD?=
 =?us-ascii?Q?CIBHiRLd4Xwv1obDNSmp/XdkTctTV1PHTDqrnWDfnnVSI7rG6bUvXMIE9w52?=
 =?us-ascii?Q?8S/yu+Ljbex6l13MkCp1qEC0/4V8Q9Y56NBBp3mhwfpdzbrnCiSYMhotpaoO?=
 =?us-ascii?Q?1wxFV+dL35RCqNBwoujLM0VjpXFS1hQa8vYwzKmC8qFxlEG6PNc8qNeC7VdU?=
 =?us-ascii?Q?rI/UbEHsFwViAvY3HquOqDgGjOqEgVmZA7dGx5EYs7nPOSpTYG+0K2iCO44d?=
 =?us-ascii?Q?G5iHhVug/iN0Kwx/SnJR2YR9Iv734GFHPoMbkFT4ZP+WWOqSJ6AkwYWA95rC?=
 =?us-ascii?Q?HnZcR8eYs79/0ol7Ny1VaAj+XL25MRm7doVeYvpvf25K+89Mn4hY2zYEenin?=
 =?us-ascii?Q?lNMGkV6mB1hqhlikwtUxERVrQBQhkNVrfqKhNxbcqFfQW9Y0T9ZX+aslcQqQ?=
 =?us-ascii?Q?dTPHT8CxvjUIhQh0HKycLm/zNhmMxyf6UdUcOuUVzPOagr7hnWZw+oLM0YPt?=
 =?us-ascii?Q?W25ZGTAPwll0hu/IAiIEnDv363VoKiOWozOPm+k8FYP8WkYGx9zSEj+m9Q/v?=
 =?us-ascii?Q?c4QbdkK7iMEvl5UNB4tYAuKB88AETcsnyfzDukrdXibw/dWMw9eM5Ot5QPL6?=
 =?us-ascii?Q?UWK6EyK8wxAgjgMlSPeq54KH+CeqLA/ng9wRVls+WxjnurbC88QXSjSy82+Y?=
 =?us-ascii?Q?x7KQDdbUBlF+eeUgfByHwAFUJm2mJJeFw3v1GC/aeMCPvWeC4+PeEkqn1PL3?=
 =?us-ascii?Q?3ErywxHTYIHUnL9d7kjEr9St7X7ZTbfkawPSAzR1B9QrgaesIGObFNGZqg86?=
 =?us-ascii?Q?Pcw08Wzl8ikwmiaJ+3jMMV+bV+o8q9MZA1aTySx9gfTglQZCpUgVx3cEmA4l?=
 =?us-ascii?Q?ltpPZU/Sg3wwB1liJypM/iJwmBvdLuAxkG+x/F2bSbpElIT+Jo83aUX8oGs9?=
 =?us-ascii?Q?BD0MXS6BKsmSORq0vjUwHgRFFhxJvkr34TXXzJipVpW1CdocikyXS7ya3hjR?=
 =?us-ascii?Q?bVxq64sb+9fPIOqWVxs6b4DKoOg65njk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MMmaf3xlxy9sRZ6sYAP9+4H9aK0T5FsWmQkFzw+hTRCMIZjwSYF6QvVilJFY?=
 =?us-ascii?Q?Smh89+NZtjvkkWxsPdNJn8cIeX/5qq/qnm4P4cvNefbS8r+/VhxDK+2qPQHs?=
 =?us-ascii?Q?mQOKD/FvpziTcuKz1X8iWefuSP9A1UZ5rdczhtUiWrHGfynJQ8Rl5E8ZUFQi?=
 =?us-ascii?Q?ZcE3Iw/v9mDFyjgrDCQtPHUFejIpeUhCs8ri/WGpg4lmxg3PCHMpXEl1Rppe?=
 =?us-ascii?Q?/ki7A0vTeezs1ZBA33SXalxmlQ24wfcoirYII2yzYJTkN3GdCh9zq7QsfgkI?=
 =?us-ascii?Q?9xZj5g1DS+/nfuO9I9tcnpVwJWYklGO3lHAJ4Pd8FlqI0vnqySu6fg1OCw7k?=
 =?us-ascii?Q?HrkXLeK4/MqqAJGivBWZjPKpiz9DSWwzPDMFOZJi2ceEtpeKAso3Jpc7OjgL?=
 =?us-ascii?Q?4JutheMaJf07KAzh1gEfRfeKiH6gdEdbrLPcRUZe9s2uZM0bBtShW514k3FE?=
 =?us-ascii?Q?eEYAHIOLWsvuyzH6B9wDRUBQsvEw9EZdBkA6Hqfry6/eP96Gg24Lbs+nSVHs?=
 =?us-ascii?Q?PoKfi8Mk2DddyNGd+aP221kf0lCnXIkx6rJZP72cN3jacmChPa6z45TQWgC/?=
 =?us-ascii?Q?vPaaIfsh2vqrKd7q7DHbu/lJ1gKVRU23O1jHucShtM6NUdzgqN0dk2sFd6dc?=
 =?us-ascii?Q?LBpaSQk6Ngjp6AkCmBydaokMy/yyc64HixGWJ1t6JPRT0Am36mWp6Y/zptgh?=
 =?us-ascii?Q?F1sbikpr7m5wdkaQydPGHEgrA4EAgwLPOGJdOEmYLp10asGXZYjlTRU0lH42?=
 =?us-ascii?Q?FkLM975K6UyuCqa2ma8JsyuR+Wgu1Kv4A1DAds/UroqtxEDNIXCmNjVzgx5l?=
 =?us-ascii?Q?sfe45IFQg+dGLoE/vh5Tdgc2e269Zbl740DPrjebYdE9sbf3wQ/w6xVKBvEN?=
 =?us-ascii?Q?sP0DFlTgBge+OlMfTuEnBrTjCkL7gD6HhwPUdxUh1XUZfFPEtMXUq1iL4/K+?=
 =?us-ascii?Q?ry+ILZAqHRtAjyHYH8v6j5NVRMuY0BenNd2GzkD+HLp0THiXV2Uyh3WCBB09?=
 =?us-ascii?Q?Cs8KqZ6LdZp4PRAb0+6GrgeGA+rRpjzBs8uPw0FJbr03yhXada581OlPCNZL?=
 =?us-ascii?Q?PS39um2syXFIHvhAB3EZyr5z9GfA72UZfWEopMxa0mWRYJaLr0ZXq9TBBArn?=
 =?us-ascii?Q?C2uTdvIFjcUZ88NvyyIuf5fi4gj3VUFSvP76giy5GfBQP4wz9Wfp+HV2tOgo?=
 =?us-ascii?Q?2d/Aa/tCqk3oiKPi1uxdnBpTRKrul2cy2IieYyP9omRWnt/QPoYk2J6xDOKx?=
 =?us-ascii?Q?Xp05ZgoasPef15YYC94rak7xvB/tIaZ5ZzKsf1W/E7dqS1bSbdOmJvizHsKY?=
 =?us-ascii?Q?dWZGAdnuM/DbDbaI5zl3Z0v6u+fno0eDYWK86dU++0Lq1SIEk1TeQbQSWkEG?=
 =?us-ascii?Q?HG4GA+ud9f/RIxgnZqyQ4WEyvhipLYLYf45C8CSfUc2l9wBShvE5hzcMsiKz?=
 =?us-ascii?Q?gcAwaD8tSnCq/a7oMY74VN5EyB1cw0KBDNV6CwXC9jz8m5MkEoNwDgymTcCf?=
 =?us-ascii?Q?F0bgMW8qd5YW/O3dKbPefQTQH1KClibF6HYyp7E3J5GmzGSFJ+HyOJKt5LFt?=
 =?us-ascii?Q?YHINNqT6mq8RqY7ppRZOCCUVtrNgO8xPhvm3Lq7W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b519bbcd-3ddb-4d67-3c4b-08de22eff2ea
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 20:05:10.3495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YULz7RG2gGGZywn5nO7gRH25bR5CEwOkZ7yV0UIH0Fl3AxeHqz/r2kuDPOXovrTA6HnuB14HzZG+Z79I5IbuZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8469

On 12.11.25 09:34:34, Dave Jiang wrote:
> 
> 
> On 11/11/25 5:54 AM, Robert Richter wrote:
> > On 04.11.25 10:13:34, Dave Jiang wrote:
> >>
> >>
> >> On 11/3/25 11:47 AM, Robert Richter wrote:
> >>> There is only support to translate addresses from an endpoint to its
> >>> CXL host bridge, but not in the opposite direction from the bridge to
> >>> the endpoint. Thus, the endpoint address range cannot be determined
> >>> and setup manually for a given SPA range of a region. If the endpoint
> >>> has address translation enabled, lock it to prevent the kernel from
> >>> reconfiguring it.
> >>>
> >>> Reviewed-by: Gregory Price <gourry@gourry.net>
> >>> Signed-off-by: Robert Richter <rrichter@amd.com>
> >>> ---
> >>>  drivers/cxl/core/atl.c | 10 ++++++++++
> >>>  1 file changed, 10 insertions(+)
> >>>
> >>> diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
> >>> index d6aa7e6d0ac5..5c15e4d12193 100644
> >>> --- a/drivers/cxl/core/atl.c
> >>> +++ b/drivers/cxl/core/atl.c
> >>> @@ -158,6 +158,16 @@ static int cxl_prm_translate_hpa_range(struct cxl_root *cxl_root, void *data)
> >>>  		return -ENXIO;
> >>>  	}
> >>>  
> >>> +	/*
> >>> +	 * There is only support to translate from the endpoint to its
> >>> +	 * parent port, but not in the opposite direction from the
> >>> +	 * parent to the endpoint. Thus, the endpoint address range
> >>> +	 * cannot be determined and setup manually. If the address range
> >>> +	 * was translated and modified, forbid reprogramming of the
> >>> +	 * decoders and lock them.
> >>> +	 */
> >>> +	cxld->flags |= CXL_DECODER_F_LOCK;
> >>
> >  
> >> Feels like this should be something the BIOS should enforce if that
> >> is the expectation? And the kernel checks and warns if that is not
> >> the case.
> > 
> > I think this is more a limitation of the kernel implementation rather
> > than the BIOS. The BIOS provides enought information by CFMWS, PRM,
> > HDM and PCI topology. In theory and if there is demand for it, support
> > could be added for driver region setup.
> 

> But shouldn't the BIOS set the decoder lock rather than the kernel
> setting a software lock flag based on assumption of the PRM based
> setup?

If BIOS locks the decoders, it cannot be removed even for the case
there the OS can actually handle it.

-Robert
