Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A0D2C181;
	Thu, 13 Feb 2025 00:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739406939; cv=fail; b=U4B5fYSMH+84jS2YwZqWIasiCkmCr3pSIyxPZ7XWOH8sZeuZ6OBBH4i1zDZpbJR73pkUxquLBVRk5wDdWr84uOp7ICZnRkDDt3hsuhXbxeFjvWyvm8wGUrf6u8ro7yT8mZ2mUqlXGutIfT7ptSZt6Ren4euEUwrvQ89c4428LeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739406939; c=relaxed/simple;
	bh=670QVrbHJ/PvUhBohhp8SXa99atuH9elGS26ch9Ts7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QDMs0uxHe/YmNNeW0amu/YMcI9AVEAYqaTWaUzTUNMhEXnEmvDIndo/slFX9etwipvTH20qzrt94gWUNyQ9wGIANuaQDXxsCIm2zODHLBIhuIOo8EQ+4h4/YxpQjLSLxNg79hPwgI3tTCchn8UOFNO0UE9RQDPypMsl/2rOkpqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=14D8G7mO; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="14D8G7mO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igG+tsi/ene//jTCI0T8MguXA/qIgG7FvtStksuY8EqvlG90SuVDslaEe5hDve8YV1kt4zcPBwcrkyi/l+U39VLVE1GibTI6DzVfmmOF1r70yFE6JcvSGqgeTcfIJDR0tvbjvT5jQpX2KhCyG2ptIi9xCLvohAZMu3Px9QGQHzUKSqnoqigai2/EGzWew3NYk7Cgfz/z6REeHkRtB9Cv8QgPkG49vTTp6UbeieWfcfCVcQfgnVt8VA3biO9kq66UUqGaHuLiUgvOOqxSNEI0VlLEIsYu4+fv0wCWGa+Qkbpbj96YeNyTL1vfIf4Z99yLY6HcgqPnr/3tZj2TmEqFZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86K4DoPQCEFuj8ISQ4k9f3alXM3ioWSPH/THyjSofgM=;
 b=s8aMz9rYtGljaPwnGvTq43OzecbW8gBMXEapzbb8A7+PIePPta3SItvlaRvkDf9wCdq6J6jU7GkY6z+4RlOstExbqwXAo8dEfTR7fPZ1Faa6yGWvHxJwIPU8D/XLWfQYXVK86yjIjXKEBYa5i1UR0wCwXw8tUScAOUFR/1u+/EYpCxVDIP2wIScX9+BOn6KatzImqZiIB7bTxtCrZsmJZYLAqBT9vH2dwEA2rbCl1be3p28GvfayoEAog4FWQmVgg3A5wflswLsovv4SEUwC+B751WEYPVX9mbiSTLVZtSdGrf4u/3HAtse0rCopxmnrirN/m2QK1PKyWgP2WKxLwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86K4DoPQCEFuj8ISQ4k9f3alXM3ioWSPH/THyjSofgM=;
 b=14D8G7mOVhLChiIS9ssAsF08i4GnIgT14a+sXDh49m3/cbqMJtNySHqLM4v4nlRPvoQTVCla/ujEcByxtEvd02cJw3vXCAzu7avT4nkgd9zXdnvNkehHRZ814iNJkclEbFyOf4JBFZqG2LNEX6JopPHHo4gAleUMAZpaciPk2Xs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.17; Thu, 13 Feb
 2025 00:35:35 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 00:35:35 +0000
Date: Thu, 13 Feb 2025 01:35:29 +0100
From: Robert Richter <rrichter@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v3 03/18] cxl/pci: cxl_hdm_decode_init: Move comment
Message-ID: <Z60-UF3VGPsyqHjX@rric.localdomain>
References: <20250211095349.981096-1-rrichter@amd.com>
 <20250211095349.981096-4-rrichter@amd.com>
 <20250212180910.00005839@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212180910.00005839@huawei.com>
X-ClientProxiedBy: FR3P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::17) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MN2PR12MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: 5850f0ee-e080-4faa-b0e8-08dd4bc6549d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pk/02bSWBmapparTO9y9L+la0Y78INkMcHL/E/DW2SKCmV8mZYyF6tEq8WBo?=
 =?us-ascii?Q?uWGcX+JHXiZgegA0Qsxxei9ERF3etw22pPXlKSVcUFxHlA2+4xA0kyALuNrP?=
 =?us-ascii?Q?m/4APKJdfIvKu20ERE4KnBH6Lh//Jf715R982GwG8wFEYVMaAl1CB9Le8dnX?=
 =?us-ascii?Q?yuar6VrfBGAfDlqbzEOSnp68t0iWyRI3UGop/BIDhLDNZqqTsUE2wp4LbaFd?=
 =?us-ascii?Q?AwnXVPt2bXdGvwM4QGjBu7jDizF5ZQP00jmSQErOo1aVEoa6YEfrc+J2J9HQ?=
 =?us-ascii?Q?hwTc1sTNeaRhfim3zKfT5zDhhhPJcZ1m0mrCB7ebA+9E4TwN4zdO8qpjvlMW?=
 =?us-ascii?Q?Jp/a9cJ70oONMsSAmyJJm69OcX+ytk/7/rAmKj90vb0ZI+u/Muxv+9XG/dcR?=
 =?us-ascii?Q?JdhZjVLftupkJ2oLeN8S3DqutcF3RhlpKHeevxdkyjSzvscDr7zEeRuKFpsA?=
 =?us-ascii?Q?7VRPJrRQEoxWqesmgdKeC0cAeo9rfy7NlEOOb7PObO1yYDq4t9tAN4qOkFRr?=
 =?us-ascii?Q?dvZrP8ZeFjm1kMjUxSZDqQtouWLloYsxgcWXxbzLlFdnVq2w/ggS1COJl+m+?=
 =?us-ascii?Q?wv99TAe6T/mWm+69DNiaBGtXboGCPppu7SA4S9/EhiTvNu+LliuU28HxHhLY?=
 =?us-ascii?Q?C4ANe2QhOAlwnTwRrpOm0IcaOCbwYBYkbjcPuz17pGAzCCZZeJDDOUMk+9bQ?=
 =?us-ascii?Q?hmtImUk6/dDQjQ42QovC9wLDTVNufbO+UV7TBoAoyQCBM6BZS298fCZ4OL4U?=
 =?us-ascii?Q?pq3Z8FWMz3h5gsmMxjjkvooW/bA6smx20QYYFsNfL3iH7IGUiDIaBXUg1Q8Q?=
 =?us-ascii?Q?zS0+dqM39RoilPOOe6/j81yymtrA1tp6uvCGx1vqsmAIxU2wDWLEM+pMoUK0?=
 =?us-ascii?Q?y/9ECRguseiyFjBQsVqo7MJFl1CVQ2A9MjlCtBOUw6nPUoAp77Dsun3Wn1GF?=
 =?us-ascii?Q?H83m2P59hlIUVPOBhjhDFgUrV9Wozb/1l16+tBOvHdONRjManXmXqf4ymmWt?=
 =?us-ascii?Q?mqj0zzChsHbyFbX1Q/h9gtwd6r37GbrcBA34dmOl8FxtaEvTxTqim8u1mNAO?=
 =?us-ascii?Q?hkNtZ6gto7oMWqT1MTTKdARcXBHsaVzo+5+Qo1egStKVsV2AIRaB+mPanWZ4?=
 =?us-ascii?Q?ShOpYQ7uLQu+mFliHxJnH4A//pCdpGD/zS9Zpsub1AByw5TdcEOJjNMdlLo9?=
 =?us-ascii?Q?DDmRJlnlKGlIFjoOU/EUoB6dvYWROp/M4l4e7E4uLXidZPSHLEQ4g6Cnapki?=
 =?us-ascii?Q?Elrhkyxh3x8jmsrPoFdpc8ykpdkYfnYbMON/GJDSUXvDbdPl5hcdxUnBrgT6?=
 =?us-ascii?Q?z63ze1jvxVWYE4+N+0h4eItz7kATeIQZ02PaUe0YeljjkOYXiBaAk9e8vXHc?=
 =?us-ascii?Q?SNl7q0y01XqVAOHBpQWl8oUmJCFs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PhHw0pb11Lnxnw3JWechsILGtahu55SISBMW12rvUVUGhdYfb3vppGnlKkRy?=
 =?us-ascii?Q?ITYtePia536milG6hFJF3E9bEDvNu0NlZ1UGDJ2d0NuIBYo794iiFLRsTkzk?=
 =?us-ascii?Q?G4GNoR87Fw2fCQp96H9+EP3cW7hMiSD4EG7bxvCAva9/3MmgyqsL2Jva1T48?=
 =?us-ascii?Q?9F5ZIZUXvOcqRhFSkPInX6uaiuWfaCJmzfLRSgyybJBGYBdODQtUiUzaXiG+?=
 =?us-ascii?Q?O+jvmmtLG54qGcddTpoyQ17vGZaqxTlVoEWph2TvTuQTbf3Ts6LX1Gh/mDRp?=
 =?us-ascii?Q?7IV6ixqcUtodNyDpKjyuyeeRh9pIQJnH8c9SyuvI7riV8uHS3gWyVe87FnTE?=
 =?us-ascii?Q?tKHAC9vy2Ibnmw+F1PnCLhzHCKWvAew8A0Ji1zV2xyMB5e9h/PZXvGkKif14?=
 =?us-ascii?Q?rR8QCpPU1cv7SgH4+FPFHhrHfRiOlEOZPwGE2AHbnOnQB6d7Pl3dQ8B4ZAJP?=
 =?us-ascii?Q?c5J4YMs9q0YP/URnTQezRXPPMhKnJWLcfc4QVr8pQrSAYCuh1HEMNtKx65PB?=
 =?us-ascii?Q?6fWNG0IH+LQLCd2yOGpLvf8a1zidvHgUcRhWBABT1o2nrGziAITQRZ05+1sx?=
 =?us-ascii?Q?20YjYvsGD78aX8cpuu2oYPKHcB7yXy/ojsv8qJMZ5ZXYdEyQfBsvajuDkhvb?=
 =?us-ascii?Q?gOq1AWlb4zDGquRJFv9V7/wd2EeIl8djtb7WRlolSYmWR8DqbteOFaxnr2SC?=
 =?us-ascii?Q?YgwjjFloVl9pB88FuEZFXBoVs9legRjWqVMQkM4UB8LYyU5h2TXvPCTYSG7Z?=
 =?us-ascii?Q?6xnZ6U2L4nnx32DK2mAkhXfZ9RM5OWuzVb8xcTJRs4kak/AzQlcP+pypgT0H?=
 =?us-ascii?Q?pZR6yeKjysI5ZE3AmeopINv18tXgPV+NFzSIAQ6bslq4yjbF5ff5AxZcXM5W?=
 =?us-ascii?Q?YysPbG2/RCd/VnzxJtsLiIMCCGmD6VP05AK3kc+Eo3s66h81m0QimWzMRo9/?=
 =?us-ascii?Q?oV11wJ4SsTx5YiauMm2UlJQggclzA6QV4izHdyNpuFIv5u/yeRJ/VK+HPbao?=
 =?us-ascii?Q?cSMgDQE78a0XknQW37CAtpSIIPhxnzNHXUniWNnuAT6TsL/DlvB/cpK3cMEC?=
 =?us-ascii?Q?gIeDltZFOYJ982KWH5RXCTch5CYNWZmzXXbM8LtWIwcGJ0iSlN5HJ8B/QfUA?=
 =?us-ascii?Q?DrP4oa6ZAxVAh7S6hqa7CoPe7EfQkZ2q742a7Hj+KBqWoZ8Ph1uOXb3PSteI?=
 =?us-ascii?Q?t+v8n8lqymXDNH9aZ72+FI9Lu/VA67i9SObFfIE4PRv0ROPFOYATF7H+x+uP?=
 =?us-ascii?Q?KZcD0BJhbmIZZoU9yylvfRkD9Ytvwsm/912rL2xKLcFa91spq7DFM0mM9osb?=
 =?us-ascii?Q?zl5n0xQtLYuoHgcQVuBvgED4PUEqKVEi9xC4R7Q5D7OI6bP3cki93jGm4WD/?=
 =?us-ascii?Q?ifDby4GNrg4L2m2ous78Q1BOx7U7SQ4NDL4GtXKQX2Q9SM5aJQzK51Yvpt2l?=
 =?us-ascii?Q?g/8X+IsPRqUYfTvYNtFDO0UunGKw0gleprF9WyL8khDdgwM+QlWhpJ/x5Pv0?=
 =?us-ascii?Q?XU+uoPAvR5MwZIi09Fj+yEKZuC3m7+U8Me0jaX46wU/SCZmNUQ0USxMERDyq?=
 =?us-ascii?Q?JSgGj2GOsp8ctXxIRYOmKmvIMjA6NIS2vLUeWqAW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5850f0ee-e080-4faa-b0e8-08dd4bc6549d
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 00:35:35.3379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65jCH2j7hq0eRYQ1OTHOiItAElzAKJxjKQJn/okgGTlpxEd8Q+JoTZFcTdHpZ6tbRzto4zfSCRkG235x23rBHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421

On 12.02.25 18:09:10, Jonathan Cameron wrote:
> On Tue, 11 Feb 2025 10:53:33 +0100
> Robert Richter <rrichter@amd.com> wrote:
> 
> > The comment applies to the check, move it there.
> 
> I think I disagree. It was in the right place as far as I can tell.
> It is an odd place for comment, but it's kind of describing
> why it is not an error to get down there.

Ah, that was not obvious to the reader. :-)

> 
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Reviewed-by: Gregory Price <gourry@gourry.net>
> > Tested-by: Gregory Price <gourry@gourry.net>
> > ---
> >  drivers/cxl/core/pci.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index f8e22bc278c3..c49efc419285 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -419,6 +419,15 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> >  	if (!hdm)
> >  		return -ENODEV;
> >  
> > +	/*
> > +	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
> > +	 * [High,Low] when HDM operation is enabled the range register values
> > +	 * are ignored by the device, but the spec also recommends matching the
> > +	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
> > +	 * are expected even though Linux does not require or maintain that
> > +	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
> > +	 * Decoder Capability Enable.
> 
> This check is about mem_enabled. Would be fine to add another comment here to
> say.

The next patch extends the comment for more clarification (I hope so).

> 
> 	/*
> 	 * If mem_enabled is not set prior configuration is irrelevant and we
> 	 * can do what we like so enable HDM decoders and ignore DVSEC registers.
> 	 */
> > +	 */
> >  	if (!info->mem_enabled) {
> >  		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
> >  		if (rc)
> > @@ -454,15 +463,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> >  		return -ENXIO;
> >  	}
> >  
> > -	/*
> > -	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
> > -	 * [High,Low] when HDM operation is enabled the range register values
> > -	 * are ignored by the device, but the spec also recommends matching the
> > -	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
> > -	 * are expected even though Linux does not require or maintain that
> > -	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
> > -	 * Decoder Capability Enable.
> > -	 */
> 
> This is the path the comment is talking about because only if we get to this
> return path are we 'skipping' the HDM decoder capability and not returning
> an error.  The path representing an HDM decoder equipped device that
> was configured by a BIOS that decided to use the DVSEC registers.
> 
> I'm not sure why we care about how the hdm decoders are programmed inthis
> case though.
> 
> I'm confused :(

There is an HDM, but it is disabled (CXL_HDM_DECODER_ENABLE is
cleared). If the DVSEC range regs do not have valid values
(!info->mem_enabled, firmware indicates it is not used), just go and
enable the HDM.

We try to use the hdm decoders here to be able to use them for a
non-auto setup. Else, decoder emulation is used
(should_emulate_decoders()) and decoders are locked
(CXL_DECODER_F_LOCK will be set).

Maybe take a look at the whole change with added comments including
patch 4/18?

I hope to not add confusion here. :-)

-Robert

> 
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, "CXL");
> 
