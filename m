Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E2A36096
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 23:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F0ATHWbU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i75WSchblHShOaQkdJh5l7fE1dv8mzXoLoYpYv20c92C1w+yeDYJB1j05mrohfvsI7X+6o8osuaSb5jsfpDOSK46Uf13myGalkxj+v+KKbtuG23M4FMPVYNUX/6e5RGMA8dCzn4i84nBDfmQszMSdHf+Z/WiSgH3g/lTB2EAJ1CJzqkKQ0Bh0U8oUkYTo2jcgQ31SrPi8YoUQ4VH7Dn9ACqAjp+x1v8CI2egaU1+sTFsfYUIPpoVTixLc2cPd4kOTdK83vgw20+opSq5xDkUiP0bm2A7UrNg4kMb1vn8dvLbzspSjEQEn/NwTFbfh+2j347hJzWsOommVnQJnvcIsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NRhC2+In2h4KORrsnItqqhXP2q7FiqoQdSX9FJBYbw=;
 b=EFBYanByxIMeYob5RK4zzWDYbLeYJWTmTHbRGJDdtXHmG6WqiXg4Mhh2WpfLJ8T+mJuruVnLBsJ12ja7gdDgWDa5cjbnSEb5tMsqx4tNdXOQ9/fzVQ9RDSiXA/SDRudQ4eHTCXMgRqghnUxBjryf9Nq/DFPUgYRMWvx0T03B0IaxaWbhq3+HbDgj+1K1KaY/TkfT/WDZ9pKsg6XCtWj07b+buxPRIGHiqr3yFI3oXFxH5dRC7HKGoWGnW0TrLJvlvo29hP7T4JRt39K39KZ2jKyLaSq7sZSLLl+xAXd7qrDu9w5s9orNLTx4tAtZyMDdukUKsXelcXu78pkAkIN72Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NRhC2+In2h4KORrsnItqqhXP2q7FiqoQdSX9FJBYbw=;
 b=F0ATHWbU6aMzL8XodRvBY/lGAiFs4ChDZQRacODTCp/R5D3Kpk0sPu8qq0u+PmpM/08FpF7ZhgWPYWteIHYOxJyShVylOgfK7LQLVxY3U0bDnHdW6ILHlcfU3/HAsjMP4KZLITpL/iCs7lvtPCllI3zLVLkmzGu/fhJE2VS+buc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8746.namprd12.prod.outlook.com (2603:10b6:208:490::7)
 by CY5PR12MB6432.namprd12.prod.outlook.com (2603:10b6:930:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 23:06:21 +0000
Received: from IA0PR12MB8746.namprd12.prod.outlook.com
 ([fe80::bc59:981e:e6da:1806]) by IA0PR12MB8746.namprd12.prod.outlook.com
 ([fe80::bc59:981e:e6da:1806%5]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 23:06:21 +0000
Date: Sat, 6 Jan 2024 00:06:14 +0100
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
	dan.j.williams@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: Re: [PATCH v6 4/5] cxl: Refactor to use __free() for cxl_root
 allocation in cxl_find_nvdimm_bridge()
Message-ID: <ZZiLZkNJb8UoB1yX@rric.localdomain>
References: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
 <170449247353.3779673.5963704495491343135.stgit@djiang5-mobl3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170449247353.3779673.5963704495491343135.stgit@djiang5-mobl3>
X-ClientProxiedBy: FR5P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::9) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8746:EE_|CY5PR12MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f7c038-f677-4362-ee81-08dc0e42edad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8GCO6hXaRqMVTcuQHht9brctS/IISNdV9nxY0UrwMB5miO8IuYpGX8QUeSTvCvDhFpNk/KUXOtBsee52NalFYqM3f6pEIbzs90tueNLX6x0BAh/04ggndfp/PZOx00dibD2noWLzh41uSNT9zE/I3tvACGoCYPPTN78Lh9otdK5CwDtFaxEFe9uCL2pMsdIgDdKerHNp5RKATbdvltOK5BbVzXVXyXftRpk3wIEMlwaDgEzjnvyGLhKqb6KTBdkbJW3lL+x/9tF1h4kQJItSmAwwamk04ySES4LKSPClIubFFRzjKsKRw5jzokGxtoVEMoS9+Ymmzg/hnypaviAtoE67xu4h6GBOakXCLtiL/QyN7nj+bRQ1tMAMXgjTSliymuYPy4mOQEGd3ZUmle4wmhOk9nCNTocIjSKxH4p8V8zI7zPKozqRgwubiJ/F9lf4TARlsQQApXkWlhrouKOgTYcp5GwADPTe2xQMddbUUI/KKbclJ2zUSeIgS5C7IkTfSIofplxcPVkBR1ALdma+qiJaC4PM1QCbA4lZYaasnwowehRuKsOFJlHd6iCjtVOf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8746.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(9686003)(26005)(53546011)(6506007)(6512007)(6666004)(83380400001)(4326008)(316002)(8676002)(5660300002)(2906002)(6486002)(478600001)(6916009)(66476007)(66946007)(66556008)(38100700002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NPNVurYeuChZVap3xqsSE8XedmvgdmltcaozeCZBrXTw7OsnjoCeNyS22K0Y?=
 =?us-ascii?Q?OuurhaNsyBmPcTfnE8hBX2VqSC2DNKTi+hh2bpf3eBeMZ2zssx6hE6EPCK32?=
 =?us-ascii?Q?6pXUBvfPT0D9PbwZhyECSosJiFxwEgS8w4b5s5mrarJxq+56skN+uFxVf/2K?=
 =?us-ascii?Q?Z+4rbUyBhQQ4YEm6PXKqp+eV8h7fPZQs222c561f02aWVLduwkFKF0P7tAGM?=
 =?us-ascii?Q?2W+8Akju1C16syBqsOhqQzlAReTb9Yh4D3FMdQfVlydHNaAkYICC43kxP7FF?=
 =?us-ascii?Q?JnufwPY6Uq6zWvGiy989SqyObDXH2UGnPNG5dYB85DAh3Pm9hcEV1TGyLSMC?=
 =?us-ascii?Q?DyasY7uYGN2dj3cfLAXvRSgCRS1/t3gF8UmQRJ+iYwFfwa04j7WbW8wI+al8?=
 =?us-ascii?Q?AFYH7i56JGyk0f95zH2teKxAcLshrzlJ0k3Uvm4PSFwrlcjEnmgvY2Ybjfc2?=
 =?us-ascii?Q?SIWk6zVpGJe43ceJ8kdlxxkeQ5uEn5DNNQaZjfzWJue9+Pb4k+HF+qW0N5Cp?=
 =?us-ascii?Q?rCoWZwd5U6HSCJGQkrdZ4Xnt0T7t8RgmjfqtgCJ+UavZlZriOv4XmyGR1o1l?=
 =?us-ascii?Q?Y22wTrwVxwHVQvW2Yw/251T0cuGhZS9nx/G1tFEmIas2kjQ7tFmvNuolIzLi?=
 =?us-ascii?Q?8nkty8IC2JU6Rq1Uet4/LmGvPy/QkH9qHXb0HutPjdNNfdYLsHlF4qNBuB8x?=
 =?us-ascii?Q?8qVCKMVSUMp/IRq1wtsypiHpc91hgUiTN3y1luJge4X5jpkmI2VSPIdyoUhy?=
 =?us-ascii?Q?dk9W0wtHVyL7UMTK5u1oKpiVBEnmeUrqizsm2F+/3Yhec/+yOlzcVIQmflpA?=
 =?us-ascii?Q?i1bB1Y4C6v5JOPnUYtWuwa7C0X56vvz6lF+/unERvM4WXhGT2OK+5jeBYIrv?=
 =?us-ascii?Q?Cb8tlWoNgYBZzj2g9Vx95hLXi1OnCemxl0AKwz0/Mnq+a8Me9c3nNmT6kAMD?=
 =?us-ascii?Q?//Mf44UeLuQhO4K07MMIRSLnXTis2uRsn9fR0LqJN14krZnDR+TpIPG0lzGV?=
 =?us-ascii?Q?E+7+S6JkxNpAaOP94spfBCj4auhknG7Wr4a5L5P7lohe/qVPC2rvzFFHJmxn?=
 =?us-ascii?Q?svUbOgV8K2i2GwIFM6NaQDs7FUySZMUVoi+y1KLtWYp+i+VZN505Xi807hNW?=
 =?us-ascii?Q?xmVTvxZ8D5htPncv3ck7oPU8O1VklJVxDT5qj03GVk+34NkaO3jfZMtAcoEo?=
 =?us-ascii?Q?k1h/giJ0Xjkf2S5aT6YhGNqVkfb0x8XopY0clqvPMVcMFd34VBFqGRQLtHmp?=
 =?us-ascii?Q?P7KfGKQ1WfrKUP0j7SAM3EURSMuv5bsS0FJ2+BN37x3yx3Oywtk7r/7Q40Ft?=
 =?us-ascii?Q?XPHq8s3WIyKM+En4+LC0EyK7PdzzvTSyxFnkcFrjkAVmeqI/xTivg3fuCx+T?=
 =?us-ascii?Q?/1EFKGm5JUz9GfEEQQrL7BMo+j+fql5i7ycrUAQLAH1Z+Y1JqH2iCR2ViJzU?=
 =?us-ascii?Q?V9+mkUKNU7YpvwUksi8eqaZXGa4CLVhXGwrBRqbuYFKeNBPr0uKr2eBtT6UP?=
 =?us-ascii?Q?8yVZEyYCFQeS8khTcLH29HU5tiWutR8I5m2o/94Pb1GGBakXRtdMQi9JWuHX?=
 =?us-ascii?Q?W4SbFUmPRrymZTOWWwvr/kYgNVhOkZXxQxMIZmsA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f7c038-f677-4362-ee81-08dc0e42edad
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 23:06:21.7554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZmYnbxc+pa+rU4IeABmB2JPnWO7g+RpPEPe+TN0bJKD7QxXhJsHLmZ78r6T5SrwcLKgD8PVk+m6uplFG2KW0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6432

On 05.01.24 15:07:53, Dave Jiang wrote:
> Use scope-based resource management __free() macro to drop the open coded
> put_device() in cxl_find_nvdimm_bridge().
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v6:
> - Cleanup put_device()
> v5
> - Update commit log (Dan)
> ---
>  drivers/cxl/core/pmem.c |    8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index da92a901b9e8..e69625a8d6a1 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -64,16 +64,14 @@ static int match_nvdimm_bridge(struct device *dev, void *data)
>  
>  struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
>  {
> -	struct cxl_root *cxl_root = find_cxl_root(cxlmd->endpoint);
> -	struct cxl_port *port;
> +	struct cxl_root *cxl_root __free(put_cxl_root) =
> +		find_cxl_root(cxlmd->endpoint);
>  	struct device *dev;
>  
>  	if (!cxl_root)
>  		return NULL;

Can the check be removed here too?

-Robert

>  
> -	port = &cxl_root->port;
> -	dev = device_find_child(&port->dev, NULL, match_nvdimm_bridge);
> -	put_device(&port->dev);
> +	dev = device_find_child(&cxl_root->port.dev, NULL, match_nvdimm_bridge);
>  
>  	if (!dev)
>  		return NULL;
> 
> 
