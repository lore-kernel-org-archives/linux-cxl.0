Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1171E70816;
	Wed, 15 Jan 2025 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736953528; cv=fail; b=pBiwkvGC0okXtmwoMbnuFKAIEg4oR1sMSAbYGJ5TrghHP1lYcy6uKR23FGYdOMGH3bbwcjFrMy5SpjQ3rWhl6SIX14svY8MB4uPIfQT+Qvb5PZuLnK1f6Yq5SlwHZCfbANlLgwlkNta7S3tR3Z8AE7Ow/Aec4swBTDvaalkwYlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736953528; c=relaxed/simple;
	bh=0OMl92ftBNXSEEIbtcqBCntegZxW8rCHuxJWYC609Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DSNuVAdfumJpem8jQfbT7nNOo+zAfTMh0spG/qyeicJO6yEf+gPiiZGyXt/eYKIDKIbHpe7BjSSxRAj67tc2CRZ1NbF/mbmGXkE4QH7dz0SMi+tz/oQEyYzjLFfQr6kCuW2g3tbAGdDoAXlo6k0eZppmgeonfHWZTC+H3S8CWJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OhiD/2vE; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OhiD/2vE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3R1xBYfua79WmHvipWm3Jpo0cGysQ3SuJme8n/NAVrwWVpEERxGOFc3nRZ24Wqqd5cOtshcwgJgSlLm8A8FglXmVoj8OTVGLHsHAUo7GXPeEyhjw7PiLtSpd1nHy6UhGRYqlKjeP/G0Z6TjJH8BaxOSiubUKpvmbjo+UNeRAdosANxYQPqNR/6bMLUmGVWpDChSwvCvt5LmNCT9GdpbkSlt1J/dgu4zR6yHeNH39IbJwr+r7wiSRBTHfOv8oMWX07Co4n/XQ5goIGSK5XpZg5vkXDakfPZksP7cloxaieC/iRDoihBFqU0XLA+udXa+fCrvmZGojPkvVqKweQxIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/riBSe+kkNWmzl4JKBgDDuf9IOnMJzR81TtWTYS044=;
 b=L8nNBFovyDIZKK/fTZLgYk8VPmPKokT9dLcxtM0XJ5NscEp+izvwR2Rk5tbkK85nKBsqwBQp4arZ72cQCJAF7XG5ybiQLEaC7VqXgtSjDInP7A85ceKXS72Qerla/at70Ypq5b+Ou9FdtaQio/Thy/734M+uWs7CuFlYV5VWYTA7jNoP1xhXWLt0t2gi7vnbDMeETs1NS63IFJUIMy9W0nj0st0nNdggc6WsTvxF9KNgteQyA9kEqqOQnJoVYmRUYJJR7DJHj3QF3Rx+7ax9Vrq9lX4e1K6OyNbnKDqjppde04CNf+Pawl7uYMSMHyvHSWpzN2sYYdIaYsIgP3eJqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/riBSe+kkNWmzl4JKBgDDuf9IOnMJzR81TtWTYS044=;
 b=OhiD/2vEqWHAAS59wtwwRT0GIXh3wSlV6BgVtiI1YuXvRAEclDmpvJ2799QL9u9ryEUKUNkNPMorUvd3N/FiLJSSUWQ+2o7RfMTjYYamZzpy1Fa6nweapC4CwOjGT/wwnm+MVz+gJz1RqgFkkuHjITiqZ6BwnatLiy6lffVVv5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 15:05:23 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 15:05:22 +0000
Date: Wed, 15 Jan 2025 16:05:16 +0100
From: Robert Richter <rrichter@amd.com>
To: Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH v1 25/29] cxl/amd: Enable Zen5 address translation using
 ACPI PRMT
Message-ID: <Z4fOrBYzIaIGCq5l@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-26-rrichter@amd.com>
 <Z4BMyVsz7bLZAFEy@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4BMyVsz7bLZAFEy@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR0P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::11) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: 5254e095-8991-4f82-ca5d-08dd35760898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k4oSAY8N9yDqcZZzuFcPWMWAT7O5GS5woADfvyLpQ7PCwTiAohZ0OyJJb5Lr?=
 =?us-ascii?Q?p2ayS8GqhVliVT8gcJyyRnKri8WV32HpzdVFjZF8PrY+0w03kyl0DnyZpyBj?=
 =?us-ascii?Q?tFn6t+JwdMVP1GJJekiaNZq25m41Ogp4xSRp5FMUOat0Qax3nWP22LAGpHsW?=
 =?us-ascii?Q?FpeQb+X78xgTSbhywP5kHsqA1t27NY8BJ788kthHu02c+1qzcvEtsoD0F3kI?=
 =?us-ascii?Q?wtzHubNj4Ya/IJ4KxMEobCdMcnP8z1ksW/BC5Z555XSKV4/IBnlVkmpAZo/I?=
 =?us-ascii?Q?U+sPEfulTpbIXzt0T/0i6W/MBPFDLmdfn8tzhN6JmcxsPS1P2X0pYpA2aPw3?=
 =?us-ascii?Q?FymJnhrjCF0Oo7z8PAW5xi6U1wBNEggDWlhu/OVE9RVsq/VYCHOqsS88sy10?=
 =?us-ascii?Q?VAdMtiDV2JQe8bJax9rC4NV1ETRFQcOo1E3Af1nN82K56/Vtt5AnxCHYsXfs?=
 =?us-ascii?Q?rTxOFbKmm+2fXflBYH0z63DetpVe/pgmLaWo2fbHsGK7KPjy0M3psMq1/x3Q?=
 =?us-ascii?Q?ZPf31Z4/UEwe0mA1lyB+891ZSD7fviqHrhYou9yMw2BOauAVGGQ4m7KED2Us?=
 =?us-ascii?Q?8Ih1gYMrfbtiMO5qywcLom8wceGxWiQi2hG5Ie7Ea8l+aROArOBFUe/Rnyfc?=
 =?us-ascii?Q?Jr0bHr+7X597+0IxosbjZko0Ig6jxvtikZeFlLN2BqF5UIto+YvNRMJI5y/m?=
 =?us-ascii?Q?YlCIWyO+FQ44m9hsi0eQaIagodugVmvarYWTEH2rBhxtYrAYCWAr8eeOTjsD?=
 =?us-ascii?Q?GTJsB15ZsTRcuaSbmaUto4AD2+owroHMzG2NmxxZK0YnrQLc5oL9Yg1fUy4+?=
 =?us-ascii?Q?9T1k9Hi+OgqqfANCx+pYtZDHbO0AMiXbVsJOE/vndj5eaW8CyjY9Y/d/e1vi?=
 =?us-ascii?Q?VDGwrgf5lUk6JkprCUtxqRoNj1WON9vn9+GeJpAkUeIiY3rWN/g2J41SW7yU?=
 =?us-ascii?Q?2xE070/T/sYjqT/WC1QC4qZKUY9Ma6s7+403ZkGXTOYB+RJhSVaVYP6wNc0Q?=
 =?us-ascii?Q?Bp8hMmnVy0FbibOsQ8UCBfHX1EBxdmj7wv3HTG/0xfyNeyL6Q/v7HT0iGfGs?=
 =?us-ascii?Q?cRvmgc8bw9lIeVk3UWIfijgx3YvVxFe5Ne15ic9rJ+1pFNZx5Ouu60aWzGIp?=
 =?us-ascii?Q?8SfhOHrXpOKT3q7oY5Ri8yB/DkvZyPEfTOc/QTNqu8EfiVGIFwEOE7KyALIF?=
 =?us-ascii?Q?t3pccn6w/7FVWV/Ew7peynV06Yyb6xyjcmDEvQTrJnSllLiDnioxg+M6nBaP?=
 =?us-ascii?Q?2Lsw9GmbIRMcP5Qn5Sj+0jFH0x7DsUCWkaqhj0TNGMdkAiVzQekwYJpMQzML?=
 =?us-ascii?Q?oKWPvZW0TgVn9ujEWHx0b2SI3YIefuJdLQyYUESmT5PM9QYX4tB2j1y1VDRE?=
 =?us-ascii?Q?wda4yV2vMWUAvn/qt4E7o+KwHNrp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?drSGbrPoCSPfKbZDZMoZplRm1Hw72j0lspixuC3hN7od4bsf3BUEqizJk2Ll?=
 =?us-ascii?Q?ZZyzAZS/cSnbhkjt6DWLabkRWz3yfwiEEd4hmJrZ1c/sMyCizo0TsEhyPRpD?=
 =?us-ascii?Q?HTm9hE4v3NBswq3up2qS7Z9Yc0Psla1m8msIoTZjkyofwRmgRlOkyHn9gzZm?=
 =?us-ascii?Q?FlzWAWOjSDw6v36OrJnNV0Rr3jRTLggwB2xNJxU64fo3qOf85ACExGbzYxKG?=
 =?us-ascii?Q?YAEbpvDnlovcwGygznwPULc+xYRVeBGOjPTZ3fMPp368RCtAKHVUzVZkklQ+?=
 =?us-ascii?Q?pYDk8j467ETViLzvCYiT74DCABONwVlW6AH7e75Xq56B1vYVc0BhVDBl1+mK?=
 =?us-ascii?Q?i1oNwZSTR/oPjtX9fZYSauYkiuRJquRORfV4gHxMZXTNOA31H11/uT9/qeac?=
 =?us-ascii?Q?+bL505VvuU4+1hy5BifhuXOFMDJXg4HlWWdKTh9xm41NFrB37odJI0NL8XR3?=
 =?us-ascii?Q?CmkYXuZnwKqOF/ZKqLlmH4QZKN606FDEzetjjpYt9B+BWsfuwVa3LTfJ0CSD?=
 =?us-ascii?Q?0llRW2+9eBEx/8OT61ntur0sjXfb2MSOcNPe0DLhvooJfttccFt1MFtNfzpw?=
 =?us-ascii?Q?FbfhFOTQ7aeBjb2PGQ1FxXgEtGJEuIS8kJ4KYhK4WqJLU0M+CFFmcp1S0PKr?=
 =?us-ascii?Q?o0K4s+mgpoKz5Br4PLPPxWJRhSTEHef7B69Bm/OuUo845BhGNhvA2SU9z32Y?=
 =?us-ascii?Q?fkIrguu6yEgZXgjKzB9Le1iw6FISY/moF2NfQLuNtgWew+f1BAlv4sxcxvnV?=
 =?us-ascii?Q?F9vCpIlQ6yTyjLD8Fcl3Wtr5Yi+W6rRejVE678rdp/GnANbstMWqCm2TL+6l?=
 =?us-ascii?Q?lje2gPYSp8b9RGRqXh4APLQMGo3PXtu4K7yr61iDFVDFLpzR7QVVIdUc8kwo?=
 =?us-ascii?Q?u5ogF1XRPYSjQgS3G+//EbzX67z7XrLHz4Cl3WgNCVAdGTWdREmFohjLprfF?=
 =?us-ascii?Q?4g1jPy5wcuTT7MJFZ1C8vZgsTWu9S7l20lurBHPCOfcKsD1ZEMXqMaYM3odc?=
 =?us-ascii?Q?Xa20vE7uW6OL9e/FSMGn26whOMgTmDyx1eNaYmSs+47Ept48CZGwRlL9aye5?=
 =?us-ascii?Q?2XvlSZIcyw3fLYgnxWFvPp8/mBOcucvDaqGsnViiEiccJeSjK+cphPaXPk5q?=
 =?us-ascii?Q?PMa4Ps5Ok0fUNzwKuendvoMnXQVkuVKNw+09rUMqVUY9bBBcAEtyUSwJS4mM?=
 =?us-ascii?Q?pzVVIhBUTDt2dBuBVODXckoLjmDRa5MsjJkrB50XnCMlov31QGkp0hU/wn7y?=
 =?us-ascii?Q?cahg/kDs8n59+l7MZHtHal+zoHW3shfmUg9m5N7Uq9p033NrQ1xOzk+ezLRs?=
 =?us-ascii?Q?qJy+npeTmGI8hrEfbvEauH+0yeRrNnJCw3vXtv9sFy0s0p9ygJVT+bCXYyGv?=
 =?us-ascii?Q?UVy8GhKm6JkMF8GQ/UMIsLnd43r2fRdYNNf09D90wTK48o7ypJy4TuuR9ifZ?=
 =?us-ascii?Q?F7wpTyxxGBTljrfjPk5IucQHb9/m8Qis27OjgRmt/UsVV3Fm8g1q8Q+slHPk?=
 =?us-ascii?Q?Rqqa4Q22FTSohqWi9tt5mjlLTlAc0rXKpk2OEWOy80hJW7fy4r/Jnu10+PRS?=
 =?us-ascii?Q?pcvQCVBFHiXU4Mg7OgNtQ0JFCMDZsSUxIIfgxIMS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5254e095-8991-4f82-ca5d-08dd35760898
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 15:05:22.5982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4RugU/5/HYoZefdNsneYTTlBzXQnBmmeNXRtjQ6eftu5h69YhkzfQk2VR4suJ5IMTn+00Gf8gV3HXLKk2r/7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334

On 09.01.25 17:25:13, Gregory Price wrote:
> On Tue, Jan 07, 2025 at 03:10:11PM +0100, Robert Richter wrote:
> > Add AMD platform specific Zen5 support for address translation.
> 
> Doing some testing here and I'm seeing some odd results, also noticing
> some naming inconsistencies
> 
> > 
> > +static u64 cxl_zen5_to_hpa(struct cxl_decoder *cxld, u64 hpa)
> > +{
> 
> Function name is _to_hpa, but hpa is an argument?

Conversion is always done from (old) HPA to (new) HPA of the parent
port. Note that the HPA of the root port/host bridge is same as SPA.
Port's in between may have an own HPA range.

> 
> Should be dpa as argument? Confusing to convert an hpa to an hpa.

We need to handle the decoder address ranges, the argument is always
the HPA range the decoder belongs to. The DPA is only on the device
side which is a different address range compared to the decoders. The
decoders do the interleaving arithmetic too and DPA range may be
different. E.g. the decoders may split requests to different endpoints
depending on the number of interleaving ways and endpoints have their
own (smaller) DPA address ranges then.

> 
> ... snip ...
> 
> > +#define DPA_MAGIC	0xd20000
> > +	base = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC);
> > +	spa  = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC + SZ_16K);
> > +	spa2 = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC + SZ_16K - SZ_256);
> 
> For two devices interleaved, the base should be the same, correct?

Same except for the interleaving offset, which is seen below (dev1
shows *100). At this stage we don't know the interleaving position of
the endpoint yet.

> 
> example: 2 128GB devices interleaved/normalized:
> 
> dev0: base(0xc051a40000) spa(0xc051a48000) spa2(0xc051a47e00)
> dev1: base(0xc051a40100) spa(0xc051a48100) spa2(0xc051a47f00)
> 
> I believe these numbers are correct.

Looks good.

> 
> (Note: Using PRMT emulation because I don't have a BIOS with this blob,
>  but this is the same emulation i have been using for about 4 months now
>  with operational hardware, so unless the translation contract changed
>  and this code expects something different, it should be correct).
> 
> ... snip ...
> > +	len = spa - base;
> > +	len2 = spa2 - base;
> > +
> > +	/* offset = pos * granularity */
> > +	if (len == SZ_16K && len2 == SZ_16K - SZ_256) {
> > +		ways = 1;
> > +		offset = 0;
> > +		granularity = 0;
> > +		pos = 0;
> > +	} else {
> > +		ways = len / SZ_16K;
> > +		offset = spa & (SZ_16K - 1);
> > +		granularity = (len - len2 - SZ_256) / (ways - 1);
> > +		pos = offset / granularity;
> > +	}
> 
> the interleave ways and such calculate out correctly
> 
> dev0: ways(0x2) offset(0x0)   granularity(0x100) pos(0x0)
> dev1: ways(0x2) offset(0x100) granularity(0x100) pos(0x1)
> 
> > +
> > +	base = base - DPA_MAGIC * ways - pos * granularity;
> > +	spa = base + hpa;
> 
> DPA(0)
> dev0: base(0xc050000000) spa(0xc050000000)
> dev1: base(0xc050000000) spa(0xc050000000)
> 
> DPA(0x1fffffffff)
> dev0: base(0xc050000000) spa(0xe04fffffff)
> dev1: base(0xc050000000) spa(0xe04fffffff)
> 
> The bases seems correct, the SPAs looks suspect.

SPA range length must be 0x4000000000 (2x 128G). That is, upper SPA
must be 0x10050000000 (0xc050000000 + 0x4000000000 - 1). This one is
too short.

The decoder range lengths below look correct (0x2000000000), the
interleaving configuration should be checked for the decoders.

> 
> dev1 should have a very different SPA shouldn't it?

No, the HPA range is calculated, not the DPA range. Both endpoints
have the same HPA range, it must be equal and this looks correct. In
the end we calculate the following here (see cxl_find_auto_decoder()):

  hpa = cxld->hpa_range;
  // endpoint's hpa range is zero-based, equivalent to:
  // hpa->start = 0;
  // hpa->end = range_len(&hpa) - 1;
  base = hpa.start = port->to_hpa(cxld, hpa.start); // HPA(0)
  spa = hpa.end = port->to_hpa(cxld, hpa.end));     // HPA(decoder_size - 1)

Again, the HPA is the address the decoder is programmed with. HPA
length is 0x2000000000 (spa - base + 1). The DPA range is (for 2 way)
half it's size. The PRM uses DPA to SPA, but we want to translate HPA
to SPA. That is we need the calculation for.

> 
> > +
> > +	/*
> > +	 * Check SPA using a PRM call for the closest DPA calculated
> > +	 * for the HPA. If the HPA matches a different interleaving
> > +	 * position other than the decoder's, determine its offset to
> > +	 * adjust the SPA.
> > +	 */
> > +
> > +	dpa = (hpa & ~(granularity * ways - 1)) / ways
> > +		+ (hpa & (granularity - 1));
> 
> I do not understand this chunk here, we seem to just be chopping the HPA
> in half to acquire the DPA.  But the value passed in is already a DPA.
> 
> dpa = (0x1fffffffff & ~(256 * 2 - 1)) / 2 + (0x1fffffffff & (256 - 1))
>     =  0xfffffffff

HPA is:

 HPA = 2 * 0x2000000000 - 1 = 0x3fffffffff

Should calculate for a 2-way config to:

 DPA = 0x1fffffffff.

Actual formula:

 dpa = HPA div (granularity * ways) * granularity + HPA mod granularity
 pos = (HPA mod (granularity * ways)) div granularity

Bits used (e.g. HPA length: 0x4000000000 = 2^38, ways: 2):

 hpa = 00000000000000000000000000XXXXXXXXXXXXXXXXXXXXXXXXXXXXXYZZZZZZZZ
 dpa = 000000000000000000000000000XXXXXXXXXXXXXXXXXXXXXXXXXXXXXZZZZZZZZ
 pos = Y

With:

 X ... base part of the address
 Y ... interleaving position
 Z ... address offset

For DPA the positional bits are removed.

> 
> I don't understand why the DPA address is suddenly half (64GB boundary).

There is probably a broken interleaving config causing half the size
of total device mem.

> 
> > +	offset = hpa & (granularity * ways - 1) & ~(granularity - 1);
> > +	offset -= pos * granularity;
> > +	spa2 = prm_cxl_dpa_spa(pci_dev, dpa) + offset;
> > +
> > +	dev_dbg(&cxld->dev,
> > +		"address mapping found for %s (dpa -> hpa -> spa): %#llx -> %#llx -> %#llx base: %#llx ways: %d pos: %d granularity: %llu\n",
> > +		pci_name(pci_dev), dpa, hpa, spa, base, ways, pos, granularity);
> > +
> 
> This results in a translation that appears to be wrong:
> 
> dev0:
> cxl decoder5.0: address mapping found for 0000:e1:00.0
>     (dpa -> hpa -> spa): 0x0 -> 0x0 -> 0xc050000000
>     base: 0xc050000000 ways: 2 pos: 0 granularity: 256
> cxl decoder5.0: address mapping found for 0000:e1:00.0
>     (dpa -> hpa -> spa): 0xfffffffff -> 0x1fffffffff -> 0xe04fffffff
>     base: 0xc050000000 ways: 2 pos: 0 granularity: 256
> 
> dev1:
> cxl decoder6.0: address mapping found for 0000:c1:00.0
> 	(dpa -> hpa -> spa): 0x0 -> 0x0 -> 0xc050000000 
> 	base: 0xc050000000 ways: 2 pos: 1 granularity: 256
> cxl decoder6.0: address mapping found for 0000:c1:00.0
> 	(dpa -> hpa -> spa): 0xfffffffff -> 0x1fffffffff -> 0xe04fffffff
> 	base: 0xc050000000 ways: 2 pos: 1 granularity: 256
> 
> These do not look correct.
> 
> Is my understanding of the PRMT translation incorrect?
> I expect the following: (assuming one contiguous CFMW)
> 
> dev0 (dpa -> hpa -> spa): 0x0          -> 0x0          -> 0xc050000000
> dev1 (dpa -> hpa -> spa): 0x0          -> 0x100        -> 0xc050000100
> dev0 (dpa -> hpa -> spa): 0x1fffffffff -> 0x3ffffffeff -> 0x1004ffffeff
> dev1 (dpa -> hpa -> spa): 0x1fffffffff -> 0x3fffffffff -> 0x1004fffffff

Yes, would be the result without the offset applied for spa2 above.
The check above calculates the *total* length of hpa and spa with out
considering the interleaving position. This is corrected using the
offset. There is no call prm_cxl_dpa_spa(dev0, 0x1fffffffff) that
returns 0x1004fffffff, but we want to check the upper boundery of the
SPA range.

> 
> Extra data: here are the programmed endpoint decoder values
> 
> [endpoint5/decoder5.0]# cat start size dpa_size interleave_ways interleave_granularity 
> 0x0
> 0x2000000000
> 0x0000002000000000
> 1
> 256
> 
> [endpoint6/decoder6.0]# cat start size dpa_size interleave_ways interleave_granularity 
> 0x0
> 0x2000000000
> 0x0000002000000000
> 1
> 256

This is correct and and must be half the size of the HPA window.

Thanks for testing.

-Robert

> 
> 
> Anyway, yeah I'm a bit confused how this is all supposed to actually
> work given that both devices translate to the same addresses.
> 
> In theory this *should* work since the root decoder covers the whole
> space - as this has been working for me previously with some hacked up
> PRMT emulation code.
> 
> [decoder0.0]# cat start size interleave_ways interleave_granularity
> 0xc050000000
> 0x4000000000
> 2
> 256
> 
> [decoder1.0]# cat start size interleave_ways interleave_granularity
> 0xc050000000
> 0x4000000000
> 1
> 256
> 
> [decoder3.0]# cat start size interleave_ways interleave_granularity 
> 0xc050000000
> 0x4000000000
> 1
> 256
> 
> [decoder5.0]# cat start size interleave_ways interleave_granularity
> 0x0
> 0x2000000000
> 1
> 256
> 
> [decoder6.0]# cat start size interleave_ways interleave_granularity 
> 0x0
> 0x2000000000
> 1
> 256
> 
> ~Gregory
