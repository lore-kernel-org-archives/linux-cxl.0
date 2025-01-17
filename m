Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4A91F78F5;
	Fri, 17 Jan 2025 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737100752; cv=fail; b=LduNmnw/l5yTooPAXkS8A/J7OdIpiWAE9gqpg18oKrb+/o3K2t1RJQsdEpfes57oMnn4kNU1HfXbTMSZjtIV6WXZgJh5bCIQf5pMMNLFfJBj5yssGHaoi8imfgySStNmpYFRlKs9xsPaaUc3iBzd3aI8T6K2HtfZRXJBGzPAQVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737100752; c=relaxed/simple;
	bh=3pRHuWaShGocCZ9iTuikGwH/fWOu+KIN23h7pIYau64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LqLmnH2LS4UmeACK9M2DBUr+v5rc2R5+sUsncqbC7pKMsbedOIocPAVfebxuraVcntOLy7o+yw5WC8lXmLAgu2ADdtlqJ1qS5IxB9vHQghuQZDQhNVzidGI+GRgpIHEgXztTDaQebSx9E2rFBt2PPgoq4dGU+7kZtTfcl2CuaG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b9c6FjP7; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b9c6FjP7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cb4JMq03qxWuYn9WOVmldHTIvkmQgwxbYMEWiy0OHK9C/4nrcTMgQ7ec7FaIhBo+sKoZCdBZ65bZPXx/hRmt2qxMBaRlMqX5HyXClM0/9bXIllJyUKRqI4Iq6LGto4z39tkh3A0CMdMs00BCWBNCNMIeM+iV/m0ZW0bu7jYtMebxyawqc78DBicwnijdHt6t7tQoQjHrHur54bgx+wbYb/aWAT5Gb3A4X9D1ajR/8rFNWjukwUR3OY2gDnbvWJQxbwrhCSIuc15NuZktgVkP0m7lKzijua0C8hwcXxl9NwhI1gbVNpCVxOZ4NDFi7S10LlybCZ6cHOBxj5ohimMMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLVIz8NGq0VsBRl3QxQVhXtToqMSurlIw2QQSv8MMv4=;
 b=pubv3ifxMIixR82jsM3jYfYpwOL6PSurJCvtSf1Q+P1MYo6MlVqd/A79dDD4cu6hPaKus5hHCwoBBMSRA6UKL1gSBP2qmFzGn8EOqPsbg3uw1dzyzmpsErLAEhxeBfYFEeflU5q1831tpaUAdTOUdNCEGfaKiYV/nJDU4uk9Ik8uLZ8tQDbaqXMy+jkFSI5MbTMwEZLTNWeimEfazZfTrvzEhSkRYvF4PN/y+tlR9qowsoCn0dVy9p0G9kkHwfA4q50/bOr26R0vWpGU0QjiCPWSSsy5544Yf/neoligQcPQWTN94XsXJCcTAAXetsQN5UuIIfFs1MmNQm7hZphrXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLVIz8NGq0VsBRl3QxQVhXtToqMSurlIw2QQSv8MMv4=;
 b=b9c6FjP7BCnIGzeI/58ZfVfGhYYVkS0YCYeYCDVHVVAm87jfxo5Hik9rvqzC82D+dnYydi7rsEgy6w99/VTABDrfGRrHZzD6yMA7ZaoAEh5ShsZb/ygppt/Ol6HGx0fVypRYwSxhzCsA0QJKYW0gzF4DpmHDDMsx/s81FE/T2yg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 07:59:06 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 07:59:06 +0000
Date: Fri, 17 Jan 2025 08:59:00 +0100
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
Message-ID: <Z4oNxLLPg0rRYIrm@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-26-rrichter@amd.com>
 <Z36eR5oXcv3rpEZ-@gourry-fedora-PF4VCD3F>
 <Z3-hlYh3voRFLG6o@rric.localdomain>
 <20250114111307.0000028b@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114111307.0000028b@huawei.com>
X-ClientProxiedBy: FR0P281CA0226.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::19) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CY8PR12MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: 4932f84a-e0a6-4a50-96af-08dd36ccd0a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kl+BgwR1my7YqvkN4cXYZ+soe0fI6r2iQVlkATjOXAVielWVlQWxEn4AyAai?=
 =?us-ascii?Q?0KaLUB+RSyIF+rD8VPdj6xfyBtwDK1ut7uTfxdsjZkbCC6FEmB4HxiL5QSCP?=
 =?us-ascii?Q?kLNB+oA7nPHYHxQK/Rhitov7gZhVTC5av6eTcJQ8qXCsEHbd2So7zJtaqWrJ?=
 =?us-ascii?Q?ihRO5kP8zoAAVg76vHNrSpw7ZZZbqD+GYnJHfnsGUwMlwMNCf0KDMx9DHGOT?=
 =?us-ascii?Q?7SWf7uzj9IGZ3OGOWCWsWAeXwBWaV/6WekZpzE1WPhUJBZyYmQvbDcWqmbug?=
 =?us-ascii?Q?kzJnVVWuBeyVs6ym4Td7hp416MZ0QWth7zibqenmCLgopUYlVwJYHWBmiXBK?=
 =?us-ascii?Q?jB8vkc9Lj9GFKTn5z0uDiXd0KjNXIFuXK6zSe8cjtVWzMch80LMMPS2Zt7oO?=
 =?us-ascii?Q?fTEnamzzF74rZTfIrbloQ0KYNIZD/dKBjUr8uD6NJf1CB5U6+01qLN8v4lco?=
 =?us-ascii?Q?ftTyvV29Rsro0sxMtXiR3ISHPQD8L3P/PrBTyTJWi0w3dLsGjBbt0iWYLmPg?=
 =?us-ascii?Q?BnZ+xe656G+8qL7xVmvY4NPNOWi184upPXSq2kTWiwobE2qhZ3E6J8lMZHBB?=
 =?us-ascii?Q?JFQ43u6T0ORWtZkODf91JkDaGy+A+QW+swo4FvICXS5LgzqJJPHZD+TYRmes?=
 =?us-ascii?Q?HWvyGTCkGlOnXkFUEVbNrDpZ/UvbPs3RCgnZ3bcVYG81qcMlreWm0W2krAPl?=
 =?us-ascii?Q?XyK0/LErCo9BNdnQ/P4EcNjT72LIybE+kv2qY3RN/ue5rZLB8VIFFyTTFc/I?=
 =?us-ascii?Q?0Wnh2jHA5yqUJNeFxSPPQDGeUNy67a2wkogckTkxYadLDfZG6vbqLVGHbBYc?=
 =?us-ascii?Q?3JDP8QSDSBFhxEBTrS7BJabmq+v5G4IuLmQSzk8V8w8FQpnIj4KYtqsEKmzD?=
 =?us-ascii?Q?Af0fyeo9JUXInb1uawaZCbxKAI6OO+VBZPt7rKHEzKJERog6d/IDN9Wnhco/?=
 =?us-ascii?Q?6l1OzcUdQbSyPDkz7kGmqRlE0agWYHhb7kPWT4BBFGpJTSatJsOKhGDP8L8j?=
 =?us-ascii?Q?PXHZEUucrMuGKxWdPolcwkYTHVYxCCoL8uyfPKChJ63XtgYhHKvEjtpVrdkt?=
 =?us-ascii?Q?HN2vIGvOljETZW2FrnH5Z/sBXM+W7zQlHxt4YFdMftiySdx1VzOZKZrcPC8P?=
 =?us-ascii?Q?D3OI40AB2cxnIJOjh1gh5aWG/EiL2haGAaSQecpHCmkv3YeaQhIqFBNnFslm?=
 =?us-ascii?Q?XbV7IQKcICAQO+NJn2g6qEoEJfF+efUqKVrhz41uiagwetdmALiCoEbQcW+R?=
 =?us-ascii?Q?4dde7zxYxcbHrNEMBI2Mlv8Hz4SUbknGUw/xBzsLFOT/O/UKeZXqBEobqSlS?=
 =?us-ascii?Q?0SfppplR1X4HCsUVsIFQnmKPZlSBBF9HyPudvxIAij2N7/INZn50l5UtDbBI?=
 =?us-ascii?Q?1Sh5xGJ4RcLI+gXSmXcePDzAkbpp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vkefaQPMgfL+/6tx/20gPb2Lh6ZzzfGF5/rmGEYT1INi3WWT7lfnnmeu97Yk?=
 =?us-ascii?Q?s92V8dNybDiV7XShhbb6s1v3DilRAWmQhkGQt7DuPiTlWjg69wvX1Jo76qk6?=
 =?us-ascii?Q?UfL2DeHUczOc36FNr7owmo/Zg9AkNiF3E8ftfYsFt7DT7HQBLakjhZ3UCoVB?=
 =?us-ascii?Q?HUVDUcclER7nhqp6Dc3jk3HaZuBcSfnevJfc2wNwX3lg/lyQAvwHpNJ0/EXW?=
 =?us-ascii?Q?Y+f103spXwhtECP5WkoLtCKgzC92WKmazySwmrJK3wTpRmZKyeGS9tBKh6h+?=
 =?us-ascii?Q?El7GCBIYLLbURhpccRHUBLN8Bmx7CFheYFwI1R95cXwThg87fZwKzo7gj40S?=
 =?us-ascii?Q?ehg/xr3XvZ1O5AuZkqZIhrl4iwsfhM9FHSz2cPMD949TPpHC+vzeyXKkIXA7?=
 =?us-ascii?Q?ItqcP+7jPFMPuBDszC63/s5jUS2nHmTsgfARlXdmKYG34OI7vVD1fuM+8rJb?=
 =?us-ascii?Q?Q3AqRQ+Mp2q35froxhoauKEWyVNftpMPqAZWG77S9e0HFND8NrYKFraicG1f?=
 =?us-ascii?Q?vc55Bfkq4be9VLLOuj5TPXRxU2EwdQciEm46ftW+DVLbm7z/Cyu5lD0XTbUQ?=
 =?us-ascii?Q?e9goDUoKz9NCGegk9EU4Hh9UBfFKjvsNpqd0upW0XRdAvCFQoBF94CVGUAkK?=
 =?us-ascii?Q?w3sa+TMuekj5/YLcTu42My6vhyWR2oOv6Z/QCq6rp57R04H0T4sHcxYc7USE?=
 =?us-ascii?Q?6QEkdZa3e8YJzJcGPgwJwYaB2HYq2epZ09qaQpJ9Ji2lR9lVfbPa+MS/016v?=
 =?us-ascii?Q?OTZWEIcylGEPukJoNLtXkZ+u6Vf2/sKbu7vpcPTxqzQ2j3QYkMO4JSve0XkC?=
 =?us-ascii?Q?lTQWoAsKkPGd56nLvybMOv9vrCV45ox3+rAHpO46rUXjFIB5KTjhJHyQs4mf?=
 =?us-ascii?Q?6r6PnIv/VYzcZo+ex/9hRvgk33B5g7rz/Mun9Dfo5IEAqf/SrXgblo3hWvWV?=
 =?us-ascii?Q?+zArLo2yreGWWl1lJVgq1kVCXilY/iVFDPzBnMt1ymF9YU6uCK8rD2gBpehr?=
 =?us-ascii?Q?o++IuKMthebUK+JR/AqfQi5iNZvPZQF2NIJS1qNk62AYf5OFK5BesX/jbFYv?=
 =?us-ascii?Q?6Z+hUi152EveyxTICZSTCoGhfVkVECWJonpM3Vsl+Iv+GnBorXIF2E3TwlXy?=
 =?us-ascii?Q?aZDWKdiazE/LWKK/CViexUEvUc2/faCy/d9qBlHCRFoa2rQbxN1QGE+Rfxt0?=
 =?us-ascii?Q?I85W2fJ1FTjal+Iyh6ZhdFyx4wng7tybSw5MF9vaifDlR4omqa7bivVQ5Idp?=
 =?us-ascii?Q?roNd3vEsvnv+QBvcax2UN5kODqU122ySh2hykPNlmF49QHxs60F9MrjcoLNO?=
 =?us-ascii?Q?xtTvjuanG7exEVBVuNaUpVBGwC2vRgh4rkZiMkSeWca0L7mDX8NYyZqPcesO?=
 =?us-ascii?Q?Mio8N+sAH+PEhP5QVMdHGzjpGZ2PpAd2GSL0PRox1o2uP5fAkmLg9CnOz4vo?=
 =?us-ascii?Q?NB+ZNYUUPfNyJ+sFR34z0qnprP+oedavE/sYNNd/3Hj5WWXUNXEMF0t4pjcE?=
 =?us-ascii?Q?axyGL4NiIOdoQ/p7iwCdb/i/9kdK7ZN4+fBz40LHtauPI4zP13NtzDJThj8H?=
 =?us-ascii?Q?oHwdsWICpuI/qRklErlH061fg5da+tQWZg0+z4J9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4932f84a-e0a6-4a50-96af-08dd36ccd0a5
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 07:59:05.9981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mw6XShch1lJfQnbaNR0ZBgFR8r6ATYH1oG+v2Qj3+jDB7U9MApH5nEWtd3HIJXz7oKCmCIObEePKAG3Gm0gz1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244

On 14.01.25 11:13:07, Jonathan Cameron wrote:
> On Thu, 9 Jan 2025 11:14:46 +0100
> Robert Richter <rrichter@amd.com> wrote:
> 
> > On 08.01.25 10:48:23, Gregory Price wrote:
> > 
> > > > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > > > index 901555bf4b73..c8176265c15c 100644
> > > > --- a/drivers/cxl/core/port.c
> > > > +++ b/drivers/cxl/core/port.c
> > > > @@ -831,6 +831,11 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
> > > >  			    &cxl_einj_inject_fops);
> > > >  }
> > > >  
> > > > +static void cxl_port_platform_setup(struct cxl_port *port)
> > > > +{
> > > > +	cxl_port_setup_amd(port);
> > > > +}
> > > > +  
> > > 
> > > Assuming this gets expanded (which it may not), should we expect this
> > > function to end up like so?
> > > 
> > > static void cxl_port_platform_setup(struct cxl_port *port)
> > > {
> > > 	cxl_port_setup_amd(port);
> > > 	cxl_port_setup_intel(port);
> > > 	cxl_port_setup_arm(port);
> > > 	... etc ...
> > > }
> > > 
> > > I suppose this logic has to exist somewhere in some form, just want to make
> > > sure this is what we want.  Either way, this is easily modifiable, so
> > > not a blocker as I said.  
> > 
> > Yes, it is exactly designed like that. I will update the patch
> > description.
> 
> If we need it on ARM then we might wrap this in an arch_cxl_port_platform_setup()
> as never building a kernel that does x86 and arm.  Could rely on stubs but that
> tends to get ugly as things grow.

I could move the function and file to core/x86/amd.c already and add
a:

 void __weak arch_cxl_port_platform_setup(struct cxl_port *port) { }

-Robert
