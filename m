Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012035.outbound.protection.outlook.com [52.101.53.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0513812E3;
	Thu, 21 May 2026 07:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348018; cv=fail; b=Vw6sCwW+QUtG+4tf8KxekWgAirirOXbNx2NmMiD3MRPp0qbgH/Ia2cJj/0l1xaQ1qQxQW92l871s0O2RqDGqtulk2+sWO+dvFRVuauZs1bPzpY0h4xKRumb7ymDnUfH6Zj8SGyRyeuifg1OKSwpC+Mc7V13eXZm/Gt/wvOsSTJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348018; c=relaxed/simple;
	bh=a4u9Ix4ocjDzozgBpm7TNIsG9ee2ADNmJ99c4zrvERI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iZ1RpgFZrOP+xTtF9nNpk+1eXoXsU92CdC7rGHrWzX5uNps1VJiGewnxwBaV0EP8JGV6tv8k60fIpac9c2llrlU+zFQ7asv54nlLMr4GhxvGclegiJYj+yZveK6n9i1DbDKJazkSqzwXwzxueCkWY/etEUmTqotvoprSdqtG2cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t87XJVQQ; arc=fail smtp.client-ip=52.101.53.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t87XJVQQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmEKaIW1vRFHXhWPrUcLGD+948qAu+u6BWJFnNEpRR7yrIiqJBPV5+kz1HhNXFisrO+VjyrrVcwMU+t/Ycy+KoVXMvWN7acTjogmLp20drLd+phNM2XOW/AWGKEaS38VV6gnJZgZ/rYxBPPYfOKPVtrcnI6MLMrofbH27kQtfo4JXM2L8JlDVrI/iZpGEQSXMM306rjFv53PoZv5Hcy/bOh+fcaByTkmovTDLextF/W060aHlPgElYd5zOFJHgFW58jZlbcLqSUjmLkPTibMWtosOnjCTZDrjK5163G6kjs4HCE4+/P1iZy6lnxHUO7Q49yMF9FsKiOVLiI2BUb4Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WABXqgu4r+NGhTdfx2Qn0r02SB1EDEo7fgaSCvEfcF8=;
 b=d+Ze3fSK79HA7Mw9ux1cuWu4Xps35GdQPIXAfMPvfJb2kpQN9/mSFGRBFI+koUAimH7J1a+iBEv7kDaFyO5NZ4nAAtAMSPazyAAupkEUKObX49sQaXH721A3UpO487Njo2wF63QY0pdYCMAz5PELi+q7uKs4AbB0DDCCe+F0TP7NlSJ7KVpImBSsLTU6uJhXGiUMmQLn6oyqJaQcUsJyeORukxgaey1t5TJJG3A1TZpi0YyOHslXkQThnCzTIwl2aigbg0bFrdnZPq5BqoizybepdeLXu/aK71lqv9aNk7kP8zvO0amRVmF1HmWK0rWtWPNO8DZ4lgVnsgNlszmp4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WABXqgu4r+NGhTdfx2Qn0r02SB1EDEo7fgaSCvEfcF8=;
 b=t87XJVQQOoNmnz9bWGakNVpJr775gYRhX6VQ7bJdIK2ZF47naWHBuOb24XEMCwZqbgEWvQVeRZIfA0b4aduHZpWiXjQ2Fk7yeMpr2PoCpJZ1tgxMhiBINPqsZ7kbeSWSsjaFMnYKgXCFlAV4ljya/dh6q4LNd80F6+HSNT3rkkmLUWGpVr7VYC9A6TfGWyC26M8j2i5lXozjNBNwHrxwUtrRVfnqArh4/U2llvHedD+TUghjsmyTgfhVXtIP4qDOGuh3wivXQTs2bguVltWujxIVw5tEt77bR9UGxM8QbFXqRagAPj4Vch139q9YMg8uLMeoBu4F+LDRI93hQhgHbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 07:20:09 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 07:20:09 +0000
Date: Thu, 21 May 2026 15:20:04 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net, 
	jonathan.cameron@huawei.com, vishal.l.verma@intel.com, ira.weiny@intel.com, 
	dan.j.williams@intel.com, fabio.m.de.francesco@linux.intel.com, ming.li@zohomail.com, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, newtonl@nvidia.com, 
	kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com
Subject: Re: [PATCH] tools/testing/cxl: Align mock CFMWS to PMD_SIZE for
 ARM64 64K pages
Message-ID: <ag6xvDyXsri2eeuq@MWDK4CY14F>
References: <20260519233523.5991-1-icheng@nvidia.com>
 <144e80e3-1813-4c77-8c43-1f350f74230c@intel.com>
 <ag52CUdAvIRjBGBw@MWDK4CY14F>
 <ag6XbPeXrwrymocP@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag6XbPeXrwrymocP@aschofie-mobl2.lan>
X-ClientProxiedBy: TP0P295CA0044.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::6)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a3b3eb-bcb8-47ec-ce6b-08deb70963ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003|6133799003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	wtvlD1cLW82gtY6tRs+/WrDQ5xv5BRc7JAIKVyAA8jQYPm1rcO4+/hkfj3q4PLS8phYBqAKgAXBpMumJ5mtNkuw+aRQASBRqboE1x1ufzjnF82uRuligLx5uipU4HPMDT1IoMNAgXtf2T225W96ErYDXx5SK6krsMhSJNHDc/EEeOCa3BhENZQOlDhAYK8LjhzeIgW+4lxqgiEJrf0C0DuONXiWWaUAKBRgfv0t+DleAT0xW+LgQGUrkLtWLZyD28Ng9KdqEFTQFjc57vz+5jYOgiQanYOzj4/xQdkxJNiu73qWOxrI1E3Md8IJ0323h5rjyw7cv31TU6uk9KOwb78+Oc42zzLFEihKyby7hzqvQlcllGjODZhXShMryG3TcK6gExDX2JiZXOpTj/1ijPWNsdWQQ4LGSe8offyS7V0N6pRaJjOjWzSqraumPsPZfcd8gX49GJ3K+nRZjsVUWENosoD8OssGvEXgU657CgivDRHKF1JQIgRVYAaG4oBW83pZlMyjsrr6t059XR4TsqEBf/spICmW17FJzWfi1VUpaTYox7R0gxwkk4SczUWYRCJJvkbZSqAb4rGcOzwUDPPm4mAyTBAcS3XatPfZKF0OFfwkMu9+KM9D4QYFdAGpzOQWTTnS+w6c7TC3/v1Fvy8ouoXOH6dN+/eFLQGgfzjFU5BHy7PfM0aWZKhRobNej
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(6133799003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8GsPxvkPQ1Ul3yhAH+h/RfLAT/Uy7P1Ko0m0y/0jOlCQ0z5LCKbrDSbqKD1M?=
 =?us-ascii?Q?wZffpMqcdMPhQLpemxnk0d3vRQ4fHDhlsAymZjk9OBvkKJh+SRMDhEDaxvvg?=
 =?us-ascii?Q?adTuzpeB8pY73bNRu24bAesSF6bkMbXKQ83rCx46m8gQd5oRU/N1Gka49qQe?=
 =?us-ascii?Q?YddlnFPPuxpRKxvHpYqn36AdcnedZpARB4v2heBoOobdYjD6zSMOaQqaLiiC?=
 =?us-ascii?Q?Z683OhKXLBnQ20XoKjYOpo0MxynJpdBuTMDBZGy14PP0Ho0n7a5IBT1y9tEr?=
 =?us-ascii?Q?Ua5ggE27Q/gPQqpJcMEjk0jRLZBFWJVdBf2qT4Wq1mqZr7QQzuVsF79gWjgJ?=
 =?us-ascii?Q?MyrS5+t7I+woUgfRBsI5mBOq0vhX3LZULEqUiTJtEj5ID8MFc9ejYsh2F6JM?=
 =?us-ascii?Q?Ky6xBm0W6nJxUPgsJ6lPDlIUs2MlS9fp/kq9SityLaY+OlpeZMH4EDcLs95Z?=
 =?us-ascii?Q?VQBBPowWkbbngPVWx767VTFMzoayvyCbTZ2qbJwSTCXOgymzEUxPK8CPI7Nh?=
 =?us-ascii?Q?jlDQ1vTofRC0H36JGSRzAFeU6S/7kSCLmI4gMqHsFRkXs1rNyxec/hV1EJ++?=
 =?us-ascii?Q?vytDtWEwpzWYs71vlD1gr07l2Tf+fp/KxJc7C0AEki0Ao6PUQOL3tZniDCn3?=
 =?us-ascii?Q?DCFdiQeYWWqXgdLpolV8PtTRf/smof5Z9Rgk1Oi1s8vw5aq90ktOvo2AjTnS?=
 =?us-ascii?Q?/q/J0fTK4psRVYvhrD7NKLtpdcPIBJyt8cO0qPUIJj0wynCwkEzV0qXCTKfP?=
 =?us-ascii?Q?aerbYyv6UwBQjEm/qC01xLC2UI6MA4mT9CazoPc/mxmOUd/I70M+A0TilGBs?=
 =?us-ascii?Q?tKa6Vh6V6ExmeyXFGOVKqoqbcb323bIrSKXYCWAN13z+HMSSBcehh9eIyemJ?=
 =?us-ascii?Q?j/2fE9bkYwWS8e2GcBvdNA0IB4jkOgKK/qNHaHPQz6Bw1IMl4Gum+V+t3RT8?=
 =?us-ascii?Q?aN065b7kBDnpsrjoshVhl0B1ZlFz93vdf5kdkVrpWf0RBjYIeJItAE57smHD?=
 =?us-ascii?Q?r6oF+ZPiK65BpElYrb1Kmb4oRPBSNGa5y/8cc0xdEPAPhMXv6SLlEVCmFIoz?=
 =?us-ascii?Q?uklC4SueIT3SscP5I5QEyEfyjoPLubjJtJWhpjG/0zOfLAS/44ysALC/XB9l?=
 =?us-ascii?Q?EnOmy6m6PC91Y/uWZCUyVYqOm8Z2292o6SivisqaReyDbQE8qCZGD54nqdeh?=
 =?us-ascii?Q?d/dn8xYesujgoZ+Fujj30MO2SJiZINIyUfsbliiM1KsYx3AscvFiD/fT8vfQ?=
 =?us-ascii?Q?e6SxgrkLzu4y3klbyEv0g/5B+K7ypL6Ima6WNrb+cKZ+0aY062dFYeFE7Gol?=
 =?us-ascii?Q?MMgwpzI+lcrPu9ga1XMcEkb/+1tdmCoa/DVvYTmdX/1j8tbmOu2JbVLgPM8t?=
 =?us-ascii?Q?yysDVY+lEhgXvtwJLSC6tZt6VuF31rIBbS0gHunjfqZ1KvA58KxpVzmAkYum?=
 =?us-ascii?Q?tcxp7PZhq1Fyd1LJTv3L5kSwcLdsqfjXSKUXbhMUogOmLBHk2UTtjLevUW/E?=
 =?us-ascii?Q?aCQQ5AN7NWesUwLz1cioFN+zXSbC9lG8BDGhF0ZGRLpD224dDxKbGcH03665?=
 =?us-ascii?Q?Xeln9XRiy5fsAHhmdM7uba5G4mRlho1dyMHDtntZ2EZ4IpVjHMds9irzae66?=
 =?us-ascii?Q?a0vJYMF0Wm8sbxEUht3rKQ+D+VqD2ItTrXCwrScg8CDmKJ+MvjoW386jnvnN?=
 =?us-ascii?Q?zRSJyqZKpdb3+lXlsfZOsgpZRwEBEQM3dRebxDq6Ae455FU1C0oyQPXpJ2Pd?=
 =?us-ascii?Q?OtGsg/KRVw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a3b3eb-bcb8-47ec-ce6b-08deb70963ee
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 07:20:09.6150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQ0GwpjCGtT1NhXPXC78hfYf/aou2eKmoNt4wTN/yuoxP98EOMufOalnFrrwpRZM2JqtpwGpJvctMu3lYugkgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730

On Wed, May 20, 2026 at 10:26:04PM +0800, Alison Schofield wrote:
> On Thu, May 21, 2026 at 11:09:09AM +0800, Richard Cheng wrote:
> > On Wed, May 20, 2026 at 11:18:23AM +0800, Dave Jiang wrote:
> > > 
> > > 
> > > On 5/19/26 4:35 PM, Richard Cheng wrote:
> > > > cxl_test allocate synthetic CFMWS HPA windows out of a gen_pool and asks
> > > > the allocator for SZ_256M alignment. It has been sufficient on x86 with
> > > > 4k pages, arm64 with 4k pages since their PMD_SIZE are 2MB.
> > > > 
> > > > But for 64k-page arm64 kernel with CONFIG_ARM64_64K_PAGES=y and
> > > > CONFIG_PGTABLE_LEVELS=3 , the PMD_SIZE is 512 MB, which is much larger
> > > > than the alignment cxl_test guarantees. That results in every CXL region
> > > > carved from that window inherits a mis-aligned start.
> > > > 
> > > > The DAX driver's cxl_dax_region_probe() then calls "alloc_dax_region()
> > > > and the probe fails with -ENOMEM, with error message
> > > > 
> > > > """
> > > >     cxl_dax_region dax_region1: probe with driver cxl_dax_region failed
> > > >                                 with error -12
> > > > """
> > > > 
> > > > It was hit while bringing up cxl_test on an ARM64 server with
> > > > ARM64_64K_PAGES config.
> > > > 
> > > > Raise the alignment passed to "alloc"mock_res()" to the larger of
> > > > SZ_256M and PMD_SIZE so that the mock CFMWS window is always at least as
> > > > well-aligned as "alloc_dax_region()" require.
> > > 
> > > https://sashiko.dev/#/patchset/20260519233523.5991-1-icheng%40nvidia.com
> > > 
> > > Do you need to adjust length as well as alloc_dax_region() also checks length alignment?
> > > 
> > > DJ
> > >
> > 
> > Hi Dave,
> > 
> > Thanks for the review. I think there're 2 things I would like to mention
> > * cfmws6's window_size is SZ_256M * 8UL, which is 2G, not 256M, only cfmws5 is 256M, so the
> > population in your scenario is narrower.
> > * The -ENOMEM comes from cxl_dax_region_probe() on the auto region, which carves mock_auto_region_size out of cfmws0,
> > which is 1G. On ARM64K_PAGES + PGTABLE_LEVELS=3, range_len == SZ_512M == PMD_SIZE and range.start == cfmws0.base_hpa.
> > Both length and start checks in alloc_dax_region() pass.
> > 
> > A region carved explicitly from cfmws5 with a non-PMD-aligned length would still be rejected, but that path was
> > already borken on this config and isn't exercised by cxl_test bringup.
> > I'll be happy to send a follow-up path that bumps cfmws5 to >=PMD_SIZE , if you think that case should be covered, too.
> > Though that's separate from the bug this patch addresses.
> > 
> 
> Consider not limiting the scope of this fix to only what
> is needed to load cxl-test module for arm64. Think of that
> issue as a motivating example to create a new rule.
> 
> Would something like this work for you?
>

Hi Alison,

Thanks for the feedback, it sounds good for me.
 
> cxl/test: Enforce PMD alignment for volatile mock regions
> 
> Problem description stays as it is now.
> 
> Plan to resolve is a new rule like...
> 
> Every volatile mock CFMWS must be PMD aligned in start and size so 
> DAX on RAM works on any supported page size config. The auto region
> carved from cfmws0 takes size and offset from mock_auto_region_size,
> so that value must be PMD aligned too.
> 

Agree.

> And to enforce that rule do 3 things:
> 1. cfmws5's window_size becomes max(SZ_256M, PMD_SIZE)
> 2. populate_cedt() aligns volatile windows to max(SZ_256M, PMD_SIZE)
> 3. cxl_test_init() check mock_auto_region_size alignment
> 
> To be clear, this suggestion is to limit applying the alignment
> to cfmws's w ACPI_CEDT_CFMWS_RESTRICT_VOLATILE. PMEM windows stay
> at SZ_256M because IIUC they don't need PMD alignment.
> 
> -- Alison
> 

No problem, I'll amend these things and make the fix more generic
in version 2.

Best regards,
Richard Cheng.


> > Best regards,
> > Richard Cheng.
> >  
> > > > 
> > > > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > > > Acked-by: Kai-Heng Feng <kaihengf@nvidia.com>
> > > > ---
> > > >  tools/testing/cxl/test/cxl.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > > > index 418669927fb0..b40e4bbcc958 100644
> > > > --- a/tools/testing/cxl/test/cxl.c
> > > > +++ b/tools/testing/cxl/test/cxl.c
> > > > @@ -497,7 +497,8 @@ static int populate_cedt(void)
> > > >  		struct acpi_cedt_cfmws *window = mock_cfmws[i];
> > > >  
> > > >  		cfmws_elc_update(window, i);
> > > > -		res = alloc_mock_res(window->window_size, SZ_256M);
> > > > +		res = alloc_mock_res(window->window_size,
> > > > +				     max_t(int, SZ_256M, PMD_SIZE));
> > > >  		if (!res)
> > > >  			return -ENOMEM;
> > > >  		window->base_hpa = res->range.start;
> > > 
> > 
