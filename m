Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C335D238C3B;
	Wed,  7 Jan 2026 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767787395; cv=fail; b=nyipoWaXcTXapnrrtUJ8Ey+6mT92+9vopzndFOiDZeNMYFiYuw9zYBcfDlXJ3/9NmgiZbKd6ndIppBygwotdW67PakaoA0BSXKskNDJD2ZTRz/fCo3GDbklEMJV944CBjwnPA0zoZYpLo3CKgjlh4O3mptiV3tJRFu7wNZrUuqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767787395; c=relaxed/simple;
	bh=PevnZu6ZQ07VXSHouMTtWQwhVVV61GahQgxFJu8QIR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gxtbh6fle7hiq4+Kraa6WIOd/m1IE9l0eVZU9KuJHIb9XMhizIs5hAIVGM/g5F9I4+MuOzibiUOgC1yuLRoCFfzmv4sXTVJhfje18ZS6AZpNEeP3v6hxuNwF92YDVz6+SNEFKytKH2g+bwQ1lhPThPqVzypYEbCDh5pvNEoAoH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yIGmWUmK; arc=fail smtp.client-ip=52.101.43.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yIGmWUmK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gk2xkgLjBQnANKxHZpF+CypMGXSHIKF8l+CoHfHLd7AAPVhXq6mgiCf4EFbsrgTHR6hPZVdfIUwAiJz6QDaLjwX3T5MtxmfZDQdrK2SaW3Q9JdRTLEoTAE15XuF2L0XEB5sx4SYU9XjjPe7GQ8wXs+CiyaIh+Nev+22IHliiL4myak3XqyFxXIxfPE0kRUXV5+4UhEt2snknMqn0SjY+t4KAdTwaRce+0XWUj2UN1MU8svqqq+9cTbOSO4xNvAPm1IY6uazufDPI++75TV8u39bldtMxuQ2v3Q1cxsKzqFgMQSWPTXtv5WILEivofqnBNYFGR/J2TdecIk2uLCvQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnp5C0hJo2P5QRbH+CZYg2QJZbSua9XiHFp+aF5N/Ic=;
 b=jgr0wqoEffjnXjNll3Guu6lxlTtyFIQibgRPHttE4QzRsdvq3BfwGolPQZFYMtxqoLffwjqkA/D+PTh6dhkUNsXFgsYYMUaFkbfDdbpVriprwFONquyLDRLzo/nGLRaP/IsIN7VayssQ/LzACK2v5Vb1E7V6OzPppfC+luA/anpLOKu+FaDTRUL3KbHMonfXw2Pvt4IdOuFTKk7ZIhr2hCfm17PkLAzzgj1ty15oxqCYnp7tc9+cwDz4k2PDprsTbYf7sPhYPbOsBNxx9D5z+nE0jEnInu3YuiRPZ6zHyEdxeMDG6Oz1bYLRl6BhURrTgCe2dqcuLTfA1q6/5NCAKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnp5C0hJo2P5QRbH+CZYg2QJZbSua9XiHFp+aF5N/Ic=;
 b=yIGmWUmK240Ex34tmNwdcPruFXhwrcNVZGbrTTfEm0WWSCRHd63eQgBMU+939rG8vgOkKaGnhXzXvPf1ZKLLMfBT8txRznGgh0ZEPUm0izqON4GmBCcSe5/zxLZSQMZM0ub7kM9Iln3QrY8tbc8HLfrP2eWl1yRwtdFujCnoYio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA1PR12MB7101.namprd12.prod.outlook.com (2603:10b6:806:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 12:03:06 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9478.005; Wed, 7 Jan 2026
 12:03:06 +0000
Date: Wed, 7 Jan 2026 13:03:00 +0100
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cxl: Check for invalid addresses returned from
 translation functions on errors
Message-ID: <aV5LdGD8lQm7AYK3@rric.localdomain>
References: <20260106172358.350724-1-rrichter@amd.com>
 <aV1XnLrAiONbeA_X@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV1XnLrAiONbeA_X@aschofie-mobl2.lan>
X-ClientProxiedBy: FR4P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::11) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA1PR12MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: f7049c40-3454-47bc-a539-08de4de4b77c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rrjdXCjgIm5YYLFGMoFvqMA7rfFFWQqkq32B9fzaVjXbhmfdoNp8UdjeKc48?=
 =?us-ascii?Q?mfglnLZqNYmK7ghBC46BYVWvtcTuZuQ0nG87sWZ2ucjbXdK8WyZhVVs/9bt8?=
 =?us-ascii?Q?j6Eq/c5nPQZdaLDizwRPRBRnOkWo+c4iq+tTr+nVpSmd6Mm1SYXdW7DkNM/Y?=
 =?us-ascii?Q?1S1IB84J1iPJatFOdoIDDTZ1VxRoZtOHOOBtIuqCO2bAZEyeaE040t0l7CnR?=
 =?us-ascii?Q?Ftk6ar7kWTHhkEFihPSfC8LCE6crIViF85TXN8/YXthIgLqWILLx4SV/qcMM?=
 =?us-ascii?Q?QkEueQAW4Z49Rs9TUFV5w9VNy7ySuur7aYL+9raU4wB45d2WSa+8zxFPZws0?=
 =?us-ascii?Q?hNeQkl8rvI/eD93erm69gHF6vnUUF4QS/aiF3TblWrwFYXRollL8m1bvd4c7?=
 =?us-ascii?Q?i43qTXmGpAFaEA+Ng3RxX0zzRwi2EsHLM5HUfet+gJOEdCPtnkxCyB9s/RKC?=
 =?us-ascii?Q?QPmJC5P1YNnv+83s2p8LUzbWm5DpsCkHwdcNV8XRf9RrP2tacUPF2Q9TroYW?=
 =?us-ascii?Q?9YKSD2gAeA+jgFPeoEg1CKluHZ9OA+y8DXanH1dNlffdhp8HNWFUd8jtRJOG?=
 =?us-ascii?Q?GUygiKraXBS9EHQUSHN4KhkpdzNk1j9oxRj8w3XSpVCLY4fQdGahLPqabYI2?=
 =?us-ascii?Q?clfrLY4lIfitQIVnkFHMl1YwCTrMO/bJnQWevfydhaam8W6tphwbDVw0G5A3?=
 =?us-ascii?Q?UY23akMNSH3PMmQ/pILGUiD6rGcp12J1dXGnhsjZeV3bvqVwokkQ73hMlugL?=
 =?us-ascii?Q?kSbFyC7uIXNYSoyz2Lynq11YZTtgoBd/+QExdeoFUO7/Sqn6U9rk48za13Lc?=
 =?us-ascii?Q?kaRByFI4izNtbZPqXwXcuZ36LNQbJRdsaECO1OccfBQVM/tWp7+aMeZ1sggg?=
 =?us-ascii?Q?ETcrKQLu7OmPopaHeYJIkkIuEGis6NytrtgzcXmu5gMAxelThw17OrsT9yHt?=
 =?us-ascii?Q?3gSBsZKh1gv+Rp1lSN4N5AtG8uZfYaaMhRSLnp8FuU5SyC2ZuFLDsrIxleFz?=
 =?us-ascii?Q?Fbkoi4Rmn+1b88ElzDeTuiE9ffnLdPzzs5MKWCVjEcifSGhwKtsMZH0onQlJ?=
 =?us-ascii?Q?9uHCt43GA37To9YddZbG8yFBGZZbMvwxK1RiiTG9B5681aI7hneePiq1+gYK?=
 =?us-ascii?Q?z2B0oppFt9jgry0Zj28TGIIWq/FUAYKyg+qnrZ3eaudGpLNDHdUnYJ+5/8pB?=
 =?us-ascii?Q?S1R7DO0LI8jIPdHtTtzMwk1QWJ5yl9HB/gY61JDoG02pidC8d+29lx6PUGCv?=
 =?us-ascii?Q?TV+WGjw8GnDPWZ3UnBy7HBg5jdPksCqFaWvI/OjgEa424VHtQekLvVpbH6+o?=
 =?us-ascii?Q?tskK+j46Aj2t89zvKnG0aErGfRugnbpCn77t+Y7YNO6LnPIkujcRSWWowaH0?=
 =?us-ascii?Q?6p5gJ9Qf8QGqL8sic6xePTXAMViDLdbemvBRdXSIL9HcjyMzGZHPXOKENlWH?=
 =?us-ascii?Q?6b3qPHP8OVd5QdydmUSsMOZrEdn9PuWy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8VAePGfQ3hHKWS2h0StIcjQik9PbxPvoUzJnsUJ0JG5Lrsd/QrY7ZFlTjvMd?=
 =?us-ascii?Q?pHkWnWUxL7C9++r9/aTkuq52XlvFL/0ZNHUBuJ9CMktJapHFy4k60gM1Zkss?=
 =?us-ascii?Q?Dr9PrxOXN39qbe2PGTaX1dAazfhfhxyvG9wJbtBF0xXFzUB5JRrS7PMgQSS/?=
 =?us-ascii?Q?Ncexu9Sh37QAHSSyvkoajUsclHoQzCYO2wDAacCiHmxdN5TRkIT7e3A1U2s/?=
 =?us-ascii?Q?MLysq/Gd1oxy/iZOYGozmawHHFskhKZ4B4/S8vpZZozaRHFktINLg3mk4fSJ?=
 =?us-ascii?Q?d2gRXg116GrphoGyRkiLRYN4Gl4SMZDRaqNzjTXRNV/uED9qF+noKt5rJXVH?=
 =?us-ascii?Q?d+NJNqhRaYFET/4/0LrGTsXulNpLE1ulMnzw1fQ0HC25YTY/629RwpaxHI4Z?=
 =?us-ascii?Q?3JPOMqab1XnW1H2NnhJ6LleXaYhC+y3jMyLk9CLnb3Miv29k/icffpGvcrzs?=
 =?us-ascii?Q?zoWql0XwoWs4qWqju2lKgaAzOAE5IIua9SF4FtFjfwLYKAF6rDsckhh7YoxJ?=
 =?us-ascii?Q?q1+1MhzVJqfXQlsdGzJlqUufWzO1kk43n29af4CCtIgU/bFQoquBQWuxFRiA?=
 =?us-ascii?Q?Icu4DRZVBX6mlX5PsRHTif6cwoScCEes1sSjrTKPPR994P/O2+GthbTpEgk9?=
 =?us-ascii?Q?k6hk9+aGG5jfcLp1jUc1I3lgJHImnqfgb6aM3jKwdlic5zaAqcbhyAJ+h4/R?=
 =?us-ascii?Q?7pFu7cAJdz2MjsoUHXjuG4G07ptRSk1T12X/x60jOqy+aRlzZvhtZNIv1F1l?=
 =?us-ascii?Q?JhT14dOUtcMS6PAEWKIEQBkskHuiDL25m4dU6qR14/XVY7Z1OvR+DypunnAA?=
 =?us-ascii?Q?Wpv9lKZmWSEOnDJalywQapDyk0bDAZnjfByF3IQ3jJgvsXO/zGalD+iJrtOe?=
 =?us-ascii?Q?gHgM4qla485hK45FV/rBFg4GCX59kyAD0NSnHkoZSIZphe2T6KzuL2XdGB0E?=
 =?us-ascii?Q?bRbGHOHXX0RqF1JFpKXS0eeQh1rh7a0WtM7Kouaxfv4dfb0AX6DNZ5qW6rFr?=
 =?us-ascii?Q?2LlpBx39Z1lQIPICrascJkz1ZDswrXr8O0PLiTRC3tFUjY9My9WqsYQO3I8O?=
 =?us-ascii?Q?iDcgqGONMaUlA3A/GSrDXiGQxKjVnJDRDaeihwAhIlXFECqmws3eU+sLDfen?=
 =?us-ascii?Q?iiVRyerhsKlTuIbx8b/1AuAM5jNnrbAnNVqKb2d8Q2q+KbClv9PR10FJK470?=
 =?us-ascii?Q?AmtkqjKooy/QwpKoUpNP26f0kGkpXEQx/CXR5Fza9Sv/ygeg6xBI0ShmW7QU?=
 =?us-ascii?Q?7R/6TE2KL0EJtBB/lS64LNNLv9H9d7n9W2C2lNe25S17hu+Qh6cDKyd2/zIh?=
 =?us-ascii?Q?C+C9XWw633aI2ewQmB8vsY33W1oKQMELDlrT4KTcXHFq8CB4Q+phkOSISiwy?=
 =?us-ascii?Q?LcVzL2sdS9VUH4Rdeea1C9qrWWz+mS6JkIYT+j2t/8DEEKTixDfTTsnhgbve?=
 =?us-ascii?Q?8Y5bTnsIAji5Wd5y3RhAZVSkLZXQxI0f/hyVxxBWpQUjYDrlV/qhn6DX/lf8?=
 =?us-ascii?Q?rinc4Zhmtjy0JZHK8P9JA3Z7HNvEZ7ukPL0Ja+/CuLAFL38KIR2CFsvEC7Rc?=
 =?us-ascii?Q?9ut8Sfy8aX3xE0FitxiuX1HDrlJiHgJ/kb700waqwY3NcdokRihq+gSL9sbj?=
 =?us-ascii?Q?qd61VYRbaoxqhV2ADBF2xWEAxTLFWkRl0cru73qrAW3EVGO9lIk/dmCAi0Mo?=
 =?us-ascii?Q?+Lh1lmmiHMBZOJ7R3/9ZH3G1TBPvm07OPQiYVaplMa95FICUZiC/VYkN8ekh?=
 =?us-ascii?Q?oCGtIjtM7A=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7049c40-3454-47bc-a539-08de4de4b77c
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 12:03:06.2915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NoZzzgEYP5qlccST2VYAJ815Cdl+SItAgZ9MEtGtnzyPTLv66znm2HgDdCt8qJVfm6QC0umoHX1wsZhunPhFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7101

On 06.01.26 10:42:36, Alison Schofield wrote:
> On Tue, Jan 06, 2026 at 06:23:58PM +0100, Robert Richter wrote:

> > @@ -3207,8 +3220,13 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
> >  		cxled = p->targets[i];
> >  		if (cxled->pos != pos)
> >  			continue;
> > +
> > +		dpa = cxl_dpa_resource_start(cxled);
> 
> We want to return -ENXIO, not 0 in this case.
> So jump out here immediately - right?
> 
> 		if (dpa == REsOURCE_SIZE_MAX)
> 			return -ENXIO;

The users of region_offset_to_dpa_result() handle the
RESOURCE_SIZE_MAX case. For that reason the dpa is not checked here.
I did not want to change the function interface with that fix.

Thanks for review.

-Robert

> 
> 
> > +		if (dpa != RESOURCE_SIZE_MAX)
> > +			dpa += dpa_offset;
> > +
> >  		result->cxlmd = cxled_to_memdev(cxled);
> > -		result->dpa = cxl_dpa_resource_start(cxled) + dpa_offset;
> > +		result->dpa = dpa;
> >  
> >  		return 0;
> >  	}
