Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2B4C05027
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Feb 2023 21:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjBNV3F (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Feb 2023 16:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjBNV3E (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Feb 2023 16:29:04 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68F3305F4
        for <linux-cxl@vger.kernel.org>; Tue, 14 Feb 2023 13:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676410114; x=1707946114;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EoyM9QGD1sbQFkKKhfhSQrgoGYxhpBGg4ONBX8oTf7w=;
  b=Vt/aFQg/Vm7Z6YPTL1Hz/omHccC4wlnsizzdJPrD0A9/SciKy+y1jmOt
   LBKTrWmZ8UHkw5iWvvBJipDeghGddUhQEFWeNDCOPB6acwiq/SF3P6Vp+
   I3ApFDk8SlPRdRpvDwV6mVjf8AKDkXAopa3RMRgc51D/t0Q3s0O2O8fEh
   nQCDggsLnEcPfCk3ZKwK80Jq12qQjE5aqBfV31Nj3a/x+8XzFO0GlVquM
   F/b+RPs4+UszpCVKAX/OokEY0g0Y27cb/rOPnY0ah7HQd3ZnRMmMKSPCb
   u+SJieSc6fxvqYlhhGfIi/5gkrljUVfCOXxgNGkf8LiqNZRMYgrivLvQ6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="331273161"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="331273161"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 13:26:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="619187682"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="619187682"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 14 Feb 2023 13:26:23 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 13:26:22 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 13:26:22 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 13:26:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/PvrPJ90/xDBVJHBaG/kL8g0Iv8LZiUh3k0pTGzC/Q9QsTjK8TfvV8WcmSgJl6DdSLFmZFfyLZODNtz+2UPC4SSn80S0TlmSGIh4oPX976coCRWlqEJClyPNjbRvCo/WsiAzG3/FuAKzi0zIu9woTwy8vJjRZe17os5zBtwk0x02NNOnojkLah9ivWoEf28yQosboe5RzKUwJy7DFBChqvwYrTHNplA8oyAZmx+yra+M8oOtiFA288/3t5NEnv/BrazgZn+TZmgoOtRSN3cPCLGUZGH3qjGHQy1LBHNptrKMQHIuCmcFcRCuAYiKpJwbTqee68DJsYMU4mK2cbyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7lIVLRe3v1ZlcSVNugrKO1WBHpozhBWdJq8OCtJUtE=;
 b=Oz2pMIew5TGDXLzrO569qSwOABY7rev3I2X7XpMcafjJ4VgUPxYeVOCCItWOxU407g/TsMqP2e8A/33jY4+OsZcMCY4GqM23eeZtwHuBkWwCp9MILB0D6vf/RHPF3KUkDMYpoTZIJowCsZAPriHblnGLOToMRtJrFcRhosXsP3zWY9jXn9qM0D417xGVuSH8qjjQYA4SBbdoudqpMI5dt1r7MQ0cV9FkfBO0rV4x8dQ64ms5+42GU4wrtiE+smeNr8k8oVx9QllIjl0PsF+XExgkHgznjxrrXMtNZ1xNYhYg8/uHuJZTpfysaSxcTYQyuPNNp2OJtWao0HQD1Wwxdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7402.namprd11.prod.outlook.com (2603:10b6:208:432::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Tue, 14 Feb
 2023 21:26:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 21:26:20 +0000
Date:   Tue, 14 Feb 2023 13:26:17 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <lukas@wunner.de>
Subject: RE: [PATCH v8] cxl: add RAS status unmasking for CXL
Message-ID: <63ebfc79dfd13_c24a529435@dwillia2-xfh.jf.intel.com.notmuch>
References: <167639402301.778884.12556849214955646539.stgit@djiang5-mobl3.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167639402301.778884.12556849214955646539.stgit@djiang5-mobl3.local>
X-ClientProxiedBy: BYAPR02CA0062.namprd02.prod.outlook.com
 (2603:10b6:a03:54::39) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: 168aa227-d7da-49ab-9480-08db0ed21d45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2G6vk1Hf3IEXokyoTPqJHoU+mvg6qL1ybLvwInKZB0PZcL/QeH8l2ynA1fuB3IvclZMirwnpXKcAjHA6dhP6UgBmLWNLVz2NTy+gs8Xuj7iVfIX6zsJej6a/hT/YvzP2YXT5O4QB4ArH62Kd0vWMCOteCiOEqDPE7S9OH6pjtVOf5NNcnqwawIRCjBNjYSzoXIQ9+onP+qokzNk2wONjwEPK202iT9d4/h0VPflpz2ug1MAYrCv87x3YRsojvJp3/pOmd+h2c4tc72dtayOy9yElOJnPlvrMOS0i5WQaq9CqMsXfaxXqoF6utvmGI72RrhiOAhGUPQBvsfzHOEjkIB5doNdU08kEmV5+Q1mYGdEYkFxG2UnRn4DNlMZc+EOhqHZPK7VYrHXsqVm9g9/O6/lwAn2c0vqKfl2RMf1bsq6gXb4TUBj42hPv9O7rN8qJ/flJ/TYhOnlzUMRadGCAwaIkbY3YTgmAb52BSOfWDIdRiZRDrbY8tT25vGMYnrZO8CkaQCStNKemd01RZRuBW6go1Tgcq+ca/MIWfxin7HAyAax2e0y7Ww0I17DDl0DtTvBFEx4tvWyrlWtTyTfVFK5UzhRRNta/DZthtrNcIPy86q8Iwkd5OyxlCWxh3GLUxBx001BrlFHJL7LXiUXB2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199018)(26005)(4326008)(82960400001)(6506007)(38100700002)(66946007)(186003)(66476007)(86362001)(6512007)(8936002)(9686003)(8676002)(66556008)(41300700001)(54906003)(478600001)(6666004)(6486002)(316002)(83380400001)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?smxMftX6ZmIP7k/SHiqLUU6PZZPpHi4pK2bLKlQVu0GSSDj+xAXwR7SJCwpt?=
 =?us-ascii?Q?35e+Wpzk2JhlzUG068JP4cCHrDxW292BJ6+rAPhE66MXAAs5caqTBkFlSOjn?=
 =?us-ascii?Q?EJIy87immlEEQKTsvfqug2SlJAeC5p7JcwSuQRot4lL+oWNReESx9CFiX4MO?=
 =?us-ascii?Q?I7EJNB+cmx3Vae8hEppQZCp/0LcKIulxUmDuRGkVydV1DrvGwp8bDlvI6H/H?=
 =?us-ascii?Q?M3mtcXoGo1X2UukVbVhpuyGY17l720kbNWuGjAlM5+xbSFtWagwl2tkSzRTQ?=
 =?us-ascii?Q?oHdW2C65U+qAoLQ4yvOGLYPYi/6oK4CG8QktZfHLsdzIsB1bHbQ6j+YQDTnp?=
 =?us-ascii?Q?eARAyyZyXuO70E2FKlAx5ytOrwjox37Rijen525Fwxgf56y1KhHxgSwWCgkA?=
 =?us-ascii?Q?CJf3dOkpWk3ee/oic0Sai3Jiu6kLwXlIaHiVx1uaK4hIg+TIloEW5N5noNVO?=
 =?us-ascii?Q?xvjrm72imONmK1Ntst3NlsqAJ68i6abE6b6hhVG0txwTLToWiWaOo6M/N3XP?=
 =?us-ascii?Q?nX7VfaeFKw1Bc+91TD7gx29gJi2+UWqOsMzilpKaUQml0KOjqnGZ5VGisVkf?=
 =?us-ascii?Q?xTC+FTeAPegK13O89pECCtj4cB2ae+ua/zFuE4OkLpKr9WDuYF8Yq/j/d1qk?=
 =?us-ascii?Q?5wBSdNd0LUUO9oG/mgmdL3QTg8W03zX9cD3gJOxrU44Lh2Zma0KBWrPJKodA?=
 =?us-ascii?Q?70x/p+cgBTI3NzHqKEfZerdD27BlmqtUviUIommGKSD5bULpGL1vhX1Q5Ub3?=
 =?us-ascii?Q?OGJg7nirhtRAlnFUWOWtpeV6GZ7ld9qBMh6Ynjqy628nUplfqLj8m0M2dXiZ?=
 =?us-ascii?Q?swzthwgjzfnkQjjPcO7s8MUhCWQGpEOMlnxltBXxBecYuarTqPg4Idz2T799?=
 =?us-ascii?Q?2tcXq6bleW283A//dAccmUz/UtiwGrop6G0OIpeXZty6uUNHV/YgmwhvQ2um?=
 =?us-ascii?Q?TufFwMvLlw+pibGKrucqSSCgme0PZ05WMWqNgWrq0ZJEZXcIDWxzLkBqFJ3n?=
 =?us-ascii?Q?eJ9gx7/m7i6PR7l1fmnk14/FEHIoMnTuuqm9wYnJ9ax+vPXT8KS54KhV/6QR?=
 =?us-ascii?Q?honicH+PpfFeesPpkmFaFWOxDSLGmZYTeqJAVSiOcAQgS+hLvgSophXy9QCn?=
 =?us-ascii?Q?6zoOXzTFi+h672MaDkMEicKH6FgJjLd8xfzgsdDWXtJa0vONZ2u8zOQXz4uW?=
 =?us-ascii?Q?hAsipKGu/i3IZ3A3y954QlBd3uW0l9lZwdjefSjAdLyz+ls7dgR19kdCjf70?=
 =?us-ascii?Q?P4KZTqvEgUfBEP5UEMzrNV+AjxR7RwCxnJZbRuFkydlp6VXTaO8Xf+QAftfF?=
 =?us-ascii?Q?7Oom3f0Bbv2EMwuGb5jw51/QgavDDpjcvcYfEpv3SM2jyxdkLbM8Z841JqXW?=
 =?us-ascii?Q?PZPISCAFbMkBxmBlgE+kUYJqzDiv1rduQEtj1ajP7x771h4i7ux6MK9xCUzR?=
 =?us-ascii?Q?ihJSJ2D/a4uJ1QjvWFdYwZ+1P829mkcH1fb1IzQzZaBfN9fs6nsr3x5ClHzw?=
 =?us-ascii?Q?g7S1YXZpspKHYiBaGic+MWkKvqasWShZuNqWhoiYguMTth1IwMMI03I4ie4O?=
 =?us-ascii?Q?M/scDA15lZw5cbfvU8p60jC73GMu4UkA23durScdmxOPzDPDciAjJbVpxK8F?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 168aa227-d7da-49ab-9480-08db0ed21d45
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 21:26:20.1640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vFWHoIuZDKFzsjqpShgbg2OPZVBv+R90qpOKokAxCPINxDiCNOUvcdousgh2JMFG2+5m7eb7shKK8YCpaKMhQiq7pk1PMimgIByU4Cb6sM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7402
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> By default the CXL RAS mask registers bits are defaulted to 1's and
> suppress all error reporting. If the kernel has negotiated ownership
> of error handling for CXL then unmask the mask registers by writing 0s.
> 
> PCI_EXP_DEVCTL capability is checked to see uncorrectable or correctable
> errors bits are set before unmasking the respective errors.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>  # pci_regs.h
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
[..]
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> @@ -728,6 +789,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_pci_ras_unmask(pdev);
> +	if (rc)
> +		dev_warn(&pdev->dev, "No RAS reporting unmasked\n");

The only failure cases in cxl_pci_ras_unmask() are that native error
handling was not acquired, or pcie_capability_read_word() fails. The
former is already reported by decode_cxl_osc_control(), and the latter
will have caused other failures before this even runs. So, lets make
this dev_dbg() because it is benign for firmware to retain CXL error
handling control and redundant to emit another log message about it.
