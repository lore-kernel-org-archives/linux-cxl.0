Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF0E1CD0C;
	Fri, 17 Jan 2025 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123069; cv=fail; b=to6D1dBfc8jPlEzaOALCuJihfNpmcxZp2MSlwuTUAHus2/IiNV+or3D6tnyM+JP2XynbD+y289fwA2CB69PNo3sErgGVRTa1WYY8en7RGO5v2oLmV/P+Bnn+d+LCH4pU0OYvpeC8QXa0Fb2/XzmJm0ISr9aKjdFBZQV9Ep0kX+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123069; c=relaxed/simple;
	bh=gHfhAyhicBP1zfCzspSX0hXDm5fuOpNlb9yY5MDRI+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EsC+oGb6UfAv51s+r4nfNJ4tL/37EeiLmvN5HD4znGnwv7NRID4Lp/KbErh2JtutA+QNc/ftJvFuwLBLKg6MZJTd2dnS0Zi6GAYh/DWhQXnOi0qTw9rRjKABFDYVnqYW7aJCdB+MIdPj1TQ05TSXFunkic86pwmbhoq1uJixLIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lLeyu2zr; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lLeyu2zr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlB/UBRNUeCPv/PK213CJhbwnDn7XNmxVApV3P/8ekKIolL8O2qfS2XmlAibNzVZET1eZ6WUsTxZ9yYh6iKaEHh7FDs6IFBYGZRiUKRCycP59sgX8adKtUMCsXMGhGxo4FKGEA18ZbJ4Kg/EpYxHHsfKV6orBZLtGnKeasanJMH4vQEdtXgpenyFr7iw8AQi8VznOseLBMGS5nFssdrpg698JArWhXFZP3F14ryDvEB1IJNH0TAPUt6+bxHZSQ7w0PbEOJKjz1ZKuXGT6Me8DUUhItaAvm14zQx51DW/EeSEiYLEcvULbN4ogukJ3ehWvyrLG293xrOtv1OvK+lYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxRt1W1Ip/LkNT4B3NZQ8cAvOUmSaldAc9qn86UErWg=;
 b=BjDxB8mNL7hCpCBIjrH9jxoQaKqDeF8AE5ozthGhRipMWzs6GwgTtcT5TN2znARRfuPBt010SP8rsEYh9aI+bSdXKQ40CNgc7kxy7wLd/DSHUV355mLLPWnKE+OZ/DkSDdQh5HkRSkh5PzdRu4hUaeWY/EfIt1wznFLC3hMANNf3/hRGL1b/YoZZHVVmhv9fjzL4uzOpVU5/Vc0fi9ZmuhSI5qm6QwtlUTPZn7Z9upue0Ruckwz2qXbbSwSE6EE+41m2AOmnejI+1FXSgv7Q1MjSI3jVSoz+J8++qSZHx1Phr0JNECFr2pm2Ruf+wldtK561hxt+PTygpEpcSEZt3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxRt1W1Ip/LkNT4B3NZQ8cAvOUmSaldAc9qn86UErWg=;
 b=lLeyu2zr+5AhlYGNXRv9pvgOvyDycOaHFKdH+AWrZnEvkPd1CQwzhWu4If9QknSWqH4nHX97xr0f7xwrA9rsz6agueFOkFEmsAKUT1Gb/lz3ZIJRhAFWbdx9BwiM9WNqqixvA3EY+9aknWQSNfDQme8gjezGGqPJSdzgNMlrp9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 14:11:04 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 14:11:04 +0000
Date: Fri, 17 Jan 2025 15:10:55 +0100
From: Robert Richter <rrichter@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gregory Price <gourry@gourry.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH v1 25/29] cxl/amd: Enable Zen5 address translation using
 ACPI PRMT
Message-ID: <Z4pk75hJqqGg21qy@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-26-rrichter@amd.com>
 <Z36eR5oXcv3rpEZ-@gourry-fedora-PF4VCD3F>
 <Z3-hlYh3voRFLG6o@rric.localdomain>
 <20250114111307.0000028b@huawei.com>
 <Z4oNxLLPg0rRYIrm@rric.localdomain>
 <20250117114642.000000b5@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117114642.000000b5@huawei.com>
X-ClientProxiedBy: FR3P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::19) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|BY5PR12MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: 3315029e-fa4d-4887-8447-08dd3700c771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H/HEE+0Oqec3tV6FF89SbEBQOtOi5uSmHp/LamHPH87JohXAMh4AHC49qwFF?=
 =?us-ascii?Q?suSaZlqK227YCo85J4mWuLq48Vq1+bc9/PLyICG7BaVWmqWoo5CjFVd3xuSf?=
 =?us-ascii?Q?aVjmMP7KeOOxTZU/+cnt+rWCSjywDRo3+Lwq9s456CksOsK091qdifofEFrc?=
 =?us-ascii?Q?bomhznYyUc6ahvaZXRrbiqE2F8HTT3GAI3+evGizkElD3Y3nX9zlm5Ub1lVT?=
 =?us-ascii?Q?Ees4fIp2WxDbyO80Jvbhx8TBBsg7mdwnRG30W6aW5mtS37bsbKEhWEisVJo5?=
 =?us-ascii?Q?Uu3edG1Y7FMUNJm5Svsj/4lINrPUMfupWr0VQICk6fv5VeORNdgPNKjUsQku?=
 =?us-ascii?Q?0PgAptQhKbLjTMrh8S1F7XP8GsWuS6JBBHnE3WMJhmPonS6EfHVhkFbpIdir?=
 =?us-ascii?Q?sog4Xk5PaRK9swb5GoDkRKJDHcU5bY10WStj5eEzRLFzere6EfBGj33wcTx7?=
 =?us-ascii?Q?qVpY4+v0tQ15nS4jwogTK1hMcatTRTyDuXryiS0uzmUd/sVCL3qH6/5Vzh4d?=
 =?us-ascii?Q?6XxvRSZLxMDSEKRgMtnlKHT802nZCQTy5Kan8IISBIge8TyW/KenwOJejwYl?=
 =?us-ascii?Q?d5XO/0SbeQkcGqHyxv7EYEC90vIz7WtbaAI2H8l/DARV6S2xDlUeVHhRdQUu?=
 =?us-ascii?Q?8xsr5sSRoPDislwNwpGTE5v42iR+F3eEljPSnN4x4f/+90+h2msi3Icp4ZWY?=
 =?us-ascii?Q?tCgM0JjVrr00VI41FOUZlaNId2+J4o0eu85UjhQA508DYy/zeoQAXgbQHZrU?=
 =?us-ascii?Q?a8+EU6fUdWox5kXonCxpl3yW1CQrH6hvfqSSQjpqo00uI8QhO7K+dvLImHco?=
 =?us-ascii?Q?rod0R7+/GIHPW88akZNFdui7w8/RTAXeXSBoy7IJlJb/A807Y5YRAwjUdmB7?=
 =?us-ascii?Q?w8OtvglKpYxfAL1wfbOVxmqSVuNwHsO+CN0UXc1WIqqc5hadFgkZowTFSa0+?=
 =?us-ascii?Q?bnn6v5uf22+fYiazqEf4+onk71JaqU0vTpuktWCrxJngJq9PKPdcUhKJLdY6?=
 =?us-ascii?Q?qJu9ohKkoj3+qG4r0klHWBYPZKCIkztsDCe+M3G2AzxvIo9RXBR0tMeDUu3w?=
 =?us-ascii?Q?aO3sbaegD7j77TKRmfrYIqZ6wWnQ+A5YwHxL96Y0Bbme3X1/CJDxf+yZsAUp?=
 =?us-ascii?Q?QpcjY6VTTRDV8wvB2XvcJ9CnNiI5u5TnY7Qcc9T+Y6ZkvNRXPlXZPzEQh+Ib?=
 =?us-ascii?Q?Yga9RKFnk8utkNNQYzLPp/1hwUm5ZJ2dzYMuT5NkERFa+N+7Mj62zd1q4bfW?=
 =?us-ascii?Q?ois4GEqlPpOncgoieNmb3v264vMr1yqSbP8hhK535jIpvOa49jepmF2oTh2w?=
 =?us-ascii?Q?10ET7b+OEt8+VavAc2AEHvPGbtrH6Z/JZkEgBfs1LR4T1pCyMGMWKk6lJhw0?=
 =?us-ascii?Q?ZPUz6gcEakdUi/5t3w78YstglFJH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z8T1EN0sPioTBbSwW8RTHAth3elMploa1CzuCgBjv6WVlEtLI6EnY9oHNjht?=
 =?us-ascii?Q?Jw3ddMJqVoK5Mu3rYbjvSbcan2Pw587I179lEYMv3gQ39B3uomqWZ0Pvawe8?=
 =?us-ascii?Q?bxUdzw84LiXLtKDp0ab8q5Z7cEiLwzMCh6OyKKahdQRNio1S+ZDkVUdSsFZF?=
 =?us-ascii?Q?hQQ8dtZ9JcEPkhJhe4gbxU6eEopyv1rpXERTlwC19JMeCoV5EoaRKMy1i9QQ?=
 =?us-ascii?Q?cWmGhhaKElXhlw27P4emnobPnGoWBwT/PUNblVVHUV3WFLCkY5w3enhY9EXh?=
 =?us-ascii?Q?Y20w3BokQw80+4mKzFJoR2BMBRQQXurGzlTEAqTD4iED0HfIi2QX+j0eNDe4?=
 =?us-ascii?Q?fmOFj+I0aYpzVClgK+UBsd/PNRC2vqpUz0atV0Q9aR/ROneZnt8FyN/UkXRg?=
 =?us-ascii?Q?sU/LdqU4iwDW77VNcxmVVYNU+N+Ily7wAwjYCzx5nMchmpLQRwZPvZIGNmFZ?=
 =?us-ascii?Q?CyRrUx0Mrtk8NmSZBQyqVPp8b+Qhh6TZX6pLdGt4l3YaTUqJWTG3asih84Ic?=
 =?us-ascii?Q?n9M6bYRt+b4pZWP0z+U28HCHj8fYDqKrhEXET027H5WgvwoyZr+F/QaAQW6r?=
 =?us-ascii?Q?hu7Hs83M8otg+LC8c+DuLV/BLHjHksWH4DeeGG2WvPWoKTWCuNQETfu1epEP?=
 =?us-ascii?Q?iGQ9OsVdTUXtPaHbdDKYg/LPEfWMWSzzQhUN81a89jacxyVQ5vjFJVZy987n?=
 =?us-ascii?Q?jfZvjtGJ5OJmteWDYhrw/gniE60AwPNW/YhVpTa0KoH8ewkVxa+gNogCZbaB?=
 =?us-ascii?Q?4NG9UWVV75ATaT+oQiLzIdFukwye7wCFU/lrxCTP+jbIZHSrvGtowQ88IRVJ?=
 =?us-ascii?Q?CAqfuImejpe4fQn83x3Lx6jGh5u+rVmMDe8zMP+oPUqGqjfgvj5X087pbWw3?=
 =?us-ascii?Q?g0mheonWjY13ulr4oyW087MEwOqtNrdkf7+Laeb6wR0r3M/HEqbw9n6RBDR9?=
 =?us-ascii?Q?xBwrySsDPDauOBod1MDOnBfyjstqx2MRHsKu6+e+a559kKPDaadfmMaFbNaT?=
 =?us-ascii?Q?Yn0gBvrYwz9I2oB52tHQv+fESqvztTkNGgqW/HF0Ql1+1AeGwlHJH4G+Nnjc?=
 =?us-ascii?Q?/bnQfU/oL4Qi+vpbYykG+xU2t0cuu8bcjGQ0Yqew69iu+5KUojEu5j0pu3Dt?=
 =?us-ascii?Q?FS7PFT360rbzwtZYCvGOLQrn65ZBVte/VSPfWhZbwiUhDO21C7RbuGoX1YTx?=
 =?us-ascii?Q?QjyDYc+nOMYaSjNzxu8/P8GUoXi/3l6CIGmFNYV+gfPGM3aVEkXL02RMv9Or?=
 =?us-ascii?Q?UejqKhVypOi9RRe/uiAmB+liHo3HaKIGw5kNZO0OmjCqOKbYaGvRHDirtPYi?=
 =?us-ascii?Q?K9F7vnvR9/s+/eBRB+uE6NGPHhsbYi6lyaucWUk9Qgm5rGAlsfEsAW85XQW9?=
 =?us-ascii?Q?h3RnTy3kQBcEbMD99LZJ+eCJRK9E55jKPwqpci7ug/+s1b2NTgWCMn+1uCrB?=
 =?us-ascii?Q?xyJVHKp167sj51ZyovQ3ThlMKeMeTmmRxaa0uYLNKYwtdVLlXvlx/N1BVF5/?=
 =?us-ascii?Q?mHpJpxJo5YLhYw7wCglM42s9ddIP2cQgg1pGqZ93fhSkzGqhrFQZXtnFOWT1?=
 =?us-ascii?Q?8Y72LK91VirpXILaWSbZZmJaV+91b3ppEBIxTFqx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3315029e-fa4d-4887-8447-08dd3700c771
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 14:11:04.3422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1SZ9u2U5iOcMAYF56ENClY++fLigiDL5/0X+XTLYk/ooGDywhop6vmuXtyBz/E1x9UbqaqQO+qA31Qt98w1kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257

On 17.01.25 11:46:42, Jonathan Cameron wrote:
> On Fri, 17 Jan 2025 08:59:00 +0100
> Robert Richter <rrichter@amd.com> wrote:
> > On 14.01.25 11:13:07, Jonathan Cameron wrote:

> > > > > static void cxl_port_platform_setup(struct cxl_port *port)
> > > > > {
> > > > > 	cxl_port_setup_amd(port);
> > > > > 	cxl_port_setup_intel(port);
> > > > > 	cxl_port_setup_arm(port);
> > > > > 	... etc ...
> > > > > }
> > > > > 
> > > > > I suppose this logic has to exist somewhere in some form, just want to make
> > > > > sure this is what we want.  Either way, this is easily modifiable, so
> > > > > not a blocker as I said.    
> > > > 
> > > > Yes, it is exactly designed like that. I will update the patch
> > > > description.  
> > > 
> > > If we need it on ARM then we might wrap this in an arch_cxl_port_platform_setup()
> > > as never building a kernel that does x86 and arm.  Could rely on stubs but that
> > > tends to get ugly as things grow.  
> > 
> > I could move the function and file to core/x86/amd.c already and add
> > a:
> > 
> >  void __weak arch_cxl_port_platform_setup(struct cxl_port *port) { }
> Something like that probably makes sense. I don't like x86 calls in what
> I'm building for arm, even if they are stubbed out ;)

Sure, will change that.

Thanks for review,

-Robert
