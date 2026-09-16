Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29BD3B0AEF
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569301; cv=fail; b=f8FOsh2wt6EmnUBS+0W4R54A4jadnZO7iE+Ssmg/FwB6XArmqWHnCJAUTy15wvYqhc0GbOWosxDWU4kMNdjdD5j2IQ6FZlyzO4cGX2HHbR5T63S+WQZ3BaFRetexgodKaMGgl+s+KJvkIVM6YqtFkxP/DxCWsxfm7vLlPuzCNeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569301; c=relaxed/simple;
	bh=kiyv4vacSBm5u6ez4Z+d/y5ogMEvgFNltOdMlnUl5CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qXkn1DkN4QPHAqA4ySlMs3RQD21MsxOFhqtngSMBgf92pH1TJZYf1MoiFGoqTM5Z3Qp5ReYNr2fWOq1hqGsLXZz6UFssbVE5KfCtTSJnr0p7RDOg7cwYlV9pnWrpwVlrVXP23bQ6Y/3n+xsbbEPCJQoksHbvoBkqLr3S/e9wdyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gtz8qFNj; arc=fail smtp.client-ip=40.93.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gtz8qFNj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCQr3zxyBClBWGuz3uSSAE51zfdUYutTWAmQ2V04SwUYXA5L4RA/8MYQRGxUlE8efmPIxzdwbcwm7zqIPJ4qh1dmmi605rt5qLd0k4RJzUDSG4fW9/ryolB+1JHvJhXNVn26WvCcqlwMTxcQfZRWA6QUYOuGs0CbH5zqIJIrkeMNMhcQmx3kWNjjoopV37DjcMpcZYAfBBuMat2fO0q8AEmj+gmgHqUn+YUhOrJPCvqNoLuwwFYg70qtkvG9s1FWw4moYWXuecKzd+CKn3ur9QRR33e7vzzTS5Pdv8appSw/NCX4Lhq4hyqTyBG1bLqGa6Q/Gg6uQoMI8grQ8+efjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0WyYXhYoIR3tSHY8P1AxlILNAU0RBZmcjCaQvdpeps=;
 b=PABkSRPxHFA0HO2CV6LNkHIYXeZhLHLhkl28gjuQqfxV5iiJnRfKr9SZotEK07IFLpPuaDnp/J+QzPV1ocCkc8qrUFg/ZBLVINjqbnOZgpERGRUg3wKMiPxx+4komBg/69gr3utaFXdCPF9OLXJYSqScfXbA52CM+8XveP5SAa8IWrJFymAp7ESZEzwEzsa7dp1meTuPQ2Udbbjq7WIwLIOrQa2S2fcr1etUFwDAU9no/p4exlz/+a7zyA5ic8JfEqKADCYmQIFoliSv2gcZ4LMonhIjBph+j0aBJN5xLKVvZGav0d4lrh6FZrtrqzi5MptlEGxZVoLgtGxREHpJOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0WyYXhYoIR3tSHY8P1AxlILNAU0RBZmcjCaQvdpeps=;
 b=Gtz8qFNjGuCs1VIZlytLdw3ZumkmkgpJ+Ib1jxnIgscNgiKlNf/giNcGy40Oe/veUBeLg29hn+g6eQxvAHO2n/grwwgN+tfZy0vF3NGPjvL6A9eJ+F/uUpuYrcaM+po8lDjTB5mcChZvnggZCU1p+8V8LMMTrhMCuHy/+XEC8tA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) by
 CH8PR12MB9839.namprd12.prod.outlook.com (2603:10b6:610:274::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Wed, 16 Sep
 2026 14:34:49 +0000
Received: from DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1]) by DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 14:34:49 +0000
Date: Wed, 16 Sep 2026 16:34:44 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v5 4/7] cxl/region: Name the interleave locals in
 cxl_port_setup_targets()
Message-ID: <aqqpBBtJ9CWYGQDT@rric.localdomain>
References: <cover.1788475206.git.alison.schofield@intel.com>
 <b3ceb52dfb0da2f164b941adff60d2db6aaac9f1.1788475206.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3ceb52dfb0da2f164b941adff60d2db6aaac9f1.1788475206.git.alison.schofield@intel.com>
X-ClientProxiedBy: FR2P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::9) To DM4PR12MB6085.namprd12.prod.outlook.com
 (2603:10b6:8:b3::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6085:EE_|CH8PR12MB9839:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c7e6775-d909-41c4-c01e-08df13ffa962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8/VvqZYB5Ui06gDhLQuNVHBQd1iSLv8vuvZm2c00hFZgBbXIdAkIc1IOziLi92/kRG2BhumLMH4OKcqLuDocT78J6cfOIKHkAT8v7NDB4m8po5Llw6b1s9GXY0JHiPanRR74xLvuyBYqyxvqbW34Gco2WSts+dFv7mFvPa+V4JMo60POzTD9Bry3Xv570hWDghAnbWECr9hOJHlLjH48DF1tGg9IPo6KurB7CIx5cNHSkhFSE760NL1JxcIpjC7X1z5qdYioBImUs6l+XuLpRbq1J68TXaS7fqTh5GjpLEv7/N7a8J2lKuVyyQAZneSR6RESzgrg2WawTD2FkKeWoEKWIkDK5d8+FrGy5RSEvQI9PHn8/CLjbX/XaMUGmiqKFQ2SCXaul1EoNQBbrkdgifsLFl4suqijTs7ga0igDT2bxBC1itowARG4EBYogk3uFO8Voh8FJQgDX8P9TdxilSSnmrPYo3fsPJelpJFBoluuJjS3Jj/Q8nqwIYFbzTJAo+Mntz2mEtQ1DjuQisbw0kI5vtQk1YtZ/fPo+o7vE+dgsYJzF7QsljTGa+TTMFZIKC2zrBcTt+QloE/fqj6JDFsut4dyFfwqiBnsR2X+B6v8ILrwgH3H1ayN/7LQ4v6SIgC08oSpUBTtxHFSGlnOyyuN2Af4Vs3FXafkr6qrWEA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6085.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dxcXdk2/jwvXV0xW1eGEXoIqJ3z5PBeARGQT2McIDPWR+72/XFyH9N+nMCz/?=
 =?us-ascii?Q?0pHmn/F/fq30alDXn1+6nXuzrfKhIJU8yUjKMV8qzGDzAZVYa8hOFso3LguD?=
 =?us-ascii?Q?rlYewdt5Jt0Oy5AczZp0ofBjh1Rtxq6eQqSMFkJoo3QYrowRMh6vWU8qgweB?=
 =?us-ascii?Q?Q56pojGM/URDo0qzUQx3Fcu6qqDzUXM2FhbsL+1c84nspjeRTDWxEp3zT5rd?=
 =?us-ascii?Q?JkXG9nopfkXTn0Bq89R4iFk+5/+NJX6Fy0rJn+d2/sxw3bet50SmfevzEBdU?=
 =?us-ascii?Q?LBV6y1jgPIDOXC/MTKnZFFVjbE/0L3YyUZtlwb5w4xDIdvq8iyOTEzHqxLy1?=
 =?us-ascii?Q?bZRrVZl4QN+FxYLvNjNb9bD+sjwfEIZ/S7ZnFuiMurlsKVfqQIPrZAPG1IgL?=
 =?us-ascii?Q?Bx0qLu9dOm5kV+CdJKibrKoF7udij5x1E4Vjf5eWrqV1m1KZ0Xiq8DCJBpGL?=
 =?us-ascii?Q?Bpd6sf+vsViIZ16oseghHxD/C8vUSw7UXsFb15iee/MAzgxgj/dkr2Gi8tEf?=
 =?us-ascii?Q?acAGgQCoIitwbMJLtlCOPZH6M5nfqU7Vk9+dYBAhMhHQa+dbTgiDRgZfyT3i?=
 =?us-ascii?Q?ZpBzpF+ztlWPX2q0OOsPaw0CtcV3bs8Z1amymYHBUJv6QyJ2AugQxCgsyA7F?=
 =?us-ascii?Q?O5QQJIpNzwPEUDq254TpgJbjykNQ1v3rd0psQQV79X/6bDDg+uILfmhexWiP?=
 =?us-ascii?Q?0iZPpBdrznLlEGDF6bDBHQCcOAk3NPuz8KvYX73qNAkt4KgfcODd78GcYimg?=
 =?us-ascii?Q?hlDojh+TrUav6Nuu05wnYksK3nJlSgXcHeHQ9XSptEYqLr0p+9Kf+oa+oO7d?=
 =?us-ascii?Q?G/9l73cKCTk3Zfv7L1sQx/7CVPhPJW89CRKGTW84iyLPWLQ3PbRDnWlxLyy0?=
 =?us-ascii?Q?32QYQrmV8p2RIrzKcIcWesRCQ29/DAYlYYO8m53Xaod5jXBTDdD3bumyUExc?=
 =?us-ascii?Q?8HnuEQZaKPBo3dQkdGo2sPkmdKJ073GRbxawA0gkysOLuZCTzx5pz6vkCfhw?=
 =?us-ascii?Q?0wY7AzNjml8P0d8cwYhioO/aW/24AWPPeGTWGLJfwLxvfwK5bNcaVzMEN7DZ?=
 =?us-ascii?Q?ZZRQXm5DyZea0oCc5zH4cDN4PHL/QjjHUE6y0rMM2YTDztcCvwcg9t7ufIyd?=
 =?us-ascii?Q?xHRm9zFjtgB+695rkvoXfAiQe4m1a/A6D6ZRnymo2+MpWz8SNoFKZHA7bf5Z?=
 =?us-ascii?Q?Id4E5iQkM+dvMiFCJTb99xAuk7C7tsmjAVsEK+OV5m6COj1MOEdayczfk/BW?=
 =?us-ascii?Q?F8UvQEW9Acfiwy1jcEXb8DchoXNPM8heA4Uo3imab3DBdumg91uv907Ap7AE?=
 =?us-ascii?Q?ieC+r8b9GuUqcTkTxi4Zt3DqqOzeH7k21tDZ7HlM8CyVCgF1mRxvLPUPJ6r0?=
 =?us-ascii?Q?FimBj3k6b36Sw+pKcfqzj0qDxJ52drsoALFsHa4/VWVivi3MFn0DIVI9gaDJ?=
 =?us-ascii?Q?PytDE/aYn9nOM1FRFBPsaBLhJi5zsd2CjHZvGiymqojKZbbuzg6gDvcPKXij?=
 =?us-ascii?Q?wAY1WV5TynbnKyCYY2mT6UvK6gRe6G7Q969GQGeKrdXaQ8kBofmG1Fz41CCZ?=
 =?us-ascii?Q?TUIe3f/IQHG637BYF44gHgAbjT4GMlFlw9aawGLkUID2wQBt7xV1KxewljE0?=
 =?us-ascii?Q?BoO5RDUjaQM3qoOgUs+1s16/7jFxm3OlbZXIICTERhMfnef8HQeBCFoSmGVC?=
 =?us-ascii?Q?pgdtBSwT0ovsXkYvE25fhYbOd0/eH5NS4547UTsYj1uKUu08?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7e6775-d909-41c4-c01e-08df13ffa962
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 14:34:49.0695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QnE/i0vcxOsUP62bmdJfcpRZ92AIqUcgv7W9Bjm4YYVvLKGITBrC1DugyWYG7VhwJvh6WvTpk5GT2bRStwsFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9839

On 03.09.26 16:23:46, Alison Schofield wrote:
> cxl_port_setup_targets() derives the interleave granularity of one decoder
> from the granularity and ways of the decoder above it, and takes that
> decoder's own ways from the topology below it. The values from the level
> above are named parent_iw and parent_ig, but the values being derived are
> the bare iw and ig, so the reader has to work out which level each one
> describes.
> 
> Rename iw and ig to child_iw and child_ig to match the parent_ prefix used
> for the level above.

Aren't my parents my child's grandparents. :-)

I fear that does not improve it. iw_up/_down? Unsure.

-Robert

> 
> No functional change.
