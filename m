Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A192381725
	for <linux-cxl@vger.kernel.org>; Fri,  2 Feb 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903755; cv=fail; b=g0HEVnGuRPiu1NLW58V2jozBb65KDYPe3eaAr0imgLZJB5o3FPv5tdqQkJ7NuVNYGlTaRyPP+7jZLirAcHhFmE7asS9ynD2XzhQw+mnum1/I2UuD1f3Q2jOmxgLIGlxqIHnfYEhAFQRK6GpVKLW2eGZbG2H7Cdg5L2eYj2gPEc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903755; c=relaxed/simple;
	bh=W0V/Sajcs+F7zqEH+zMNQGs3n4iVM/gGcq/i6k9QERw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aPynp4NleN2eGgqQ7u2URMVKXbtOzUanIDD8cDzDXtXZsgUNbOz0UAaS9M4pNvA4d5qpROoEzhM7si8yCyTom6+JdWLrUVJfvZmMI1RHfiKVXo2xx9znFUBk36azWb0YMn3//1LzpTYS9aGcNV714h7S93zHKqeWy37b2IPK3Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d1zkdTjp; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d1zkdTjp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706903754; x=1738439754;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W0V/Sajcs+F7zqEH+zMNQGs3n4iVM/gGcq/i6k9QERw=;
  b=d1zkdTjpPiV5tVD8GEI4Vvw4KT/kuCiD4X7Dh5QebimBx0DqYdpx4Q9T
   i4+ZBog9O18SWBsqOjOljFQCxNCWPr6KnIYdLeX/WJPsqJquQTtSJ8b5U
   7WbbC5bZIr8RtZ1zrcjtZ1wCcXVEPUHEnaqGhBAOOB13iwwjJkQ736z9A
   mYPD5XX8rWpspkl2R7+QO5URWgkDGgC+u5AfNRYVF5ju1uT/HSayToNlF
   0QstUPtlkprGclEdsKo/QxG0GAXP9PwK6Eytp0VjewLFvP3nbXVIjhwxf
   CFeKqLW+eAFBmHX5jPu9G6N/8aaJfi/2wz5GYmXCauxjLzIu5sDajRi16
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="387991"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="387991"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 11:55:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="31254410"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 11:55:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 11:55:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 11:55:51 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 11:55:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/aj4ElG72MFpozaUXfSXEbfbbtTzBvRXKnmr9tbajC78k2mX6hot4IvTfPv5cDzvv950J/lV9YgY1Wj0vyTec13l5fnUunK+KRdQ/Egg9iCeoWPC5tI/UGrx8ojmUEq68qc/emwKL+o5c9UWnEWYfcSlXA4lINgD33VnWX9DB9UfG/WvkMGUQvyD2LUfVgbmft6M2KhL12GQCBftoilq5HCL/2f7qrZiFY+WwWBbp4tdtoK1zuWLsy9Sjrn+7uv3FuHFX9wWdoTCF8CVrhuvbqH6ERBH4xy07KasoWjXKHvpgJBOW32O99X6XOmtRE2KW60boG2YvyjAvU9P+tGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qz9HnD6EzAQm1INerOg54O7pjIetswGMUJxMbcK5MQ=;
 b=DhkbYPBNSMBytXfdgIU5+YUbVEwkc0GfhOwaRd28fQY2QgTHNfWa8CXhHqKD9j/sp84EE2m6UsY2mbFJ806Tb8romNp/Ns+44WGi+bYlOIaLzQbVnsp0O/H2I64D6YBXS+0/NhChqUjcAnrzEEYyDKT8sOxzCBIgmmcN3TmpHfC4JH1d4F8nJ97eHbUZgsf9MYF9VvVyhy8JDHzVbMITlRKdiml3kBY0zI06PlvFn2gFn9EBTng6CtWwKmNNslK4GooAFqL0io2Oj19NECxljkNBUNeS+VH67IrYnrbJhre6fSBDQ1dXYLN3v2Tbp9dnBRH5izErzWvKBUOmZwisfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6687.namprd11.prod.outlook.com (2603:10b6:806:25a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Fri, 2 Feb
 2024 19:55:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 19:55:43 +0000
Date: Fri, 2 Feb 2024 11:55:41 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Zhang <jonathan.zhang@asteralabs.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "dan.williams@intel.com" <dan.williams@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>
Subject: Re: how to associate cxl_pci device with cxl_mem device
Message-ID: <65bd48bd9a98a_71932294c7@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <DM4P221MB0932B81DCE6B03503E2927D8F4422@DM4P221MB0932.NAMP221.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM4P221MB0932B81DCE6B03503E2927D8F4422@DM4P221MB0932.NAMP221.PROD.OUTLOOK.COM>
X-ClientProxiedBy: MW4PR04CA0085.namprd04.prod.outlook.com
 (2603:10b6:303:6b::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: eea1e8ef-1c0b-44a6-cf8b-08dc2428f0a9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5DwXTw2Y4c25u1qgg7SANAWFbHF873iz7TZbkYnGDWlciHB7rVvhX5aWkpesyIT6mE19sL/kB3cQr7Bi1a9I/wHwtiXdtNN5HKP/wHKeH/kDhZkkGhYu/MO/HGCm00aLrBwnKKVqsgtybRD2TJhjoGRl12CMoX8idGGYNnFjvQlMpZpGB4lyawm0zVOKgXB7nELgNsvlIWxR9vgu+mSBDyA64nL5Cs2LsriJniju8uFy++GBpExXLi/qJl/Vi90WQqmvle27Ty3m3bU0AE9H4dLFgu5AWpXZQ6HFG6cQdb+GxIi6aKj5yRORVnViYM9H1WXuYb09pL/KAVbmnXbCrcoG46fMe7KLtW8f3BTqGEhx+hah2sIJwfOjSya6XrkdumzNd9XbjXj4BdCzf1mlUWm9IstQes4v46MVfPPGyKbLClFKiAoBvCBsCur1MqsMLOpATbpipcdHywItDoR555XGOH5LyBxNqlPPLBtlgAjOl5hOJfGgYasRyJb+MH36Vtq2lRZ2tzYwzkZdb7lwzpoiaL5OCAO8ChN+ECAxQrtRGnaUq/sJKlzYCilzRj/a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(478600001)(6486002)(66556008)(110136005)(66946007)(54906003)(66476007)(5660300002)(316002)(86362001)(8676002)(4326008)(2906002)(38100700002)(82960400001)(8936002)(41300700001)(26005)(83380400001)(9686003)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nhdI8Bnvb7urRpGv3NwNQzTgnMifsj4lqG4wo6Ko/X8Ok3kKJjSQc1wf4Y8l?=
 =?us-ascii?Q?o/P6HGbW8s6zwlmRB3bHC/CG11VGNC6R0GQTzaAFVic+Beh8/oz6cbDI7aza?=
 =?us-ascii?Q?IMGkPUAa8lrGhA2SZTtj/tYDtY6RmKRGVBUuCRY37dxHjsI6ySdjr0yDiiDF?=
 =?us-ascii?Q?Xfzzf4PD5XWzvtSurevDPJhdxtp6gpqu2t51rxlzpv+AQIOpsfeXpq14HDXG?=
 =?us-ascii?Q?vetLvG7nxyUpc98+1ob2TT+VotJqVaTUl4gTNcEK45KJXlIOnH3vxwh4427g?=
 =?us-ascii?Q?M41g4/EQjbF6XAZ6J8vyOmIfQ7bnu/8ETOYu+DXk7BBnNj2rsJMGUlryuT9z?=
 =?us-ascii?Q?E7UMgGtUW/zOi1K9nO7SyOTJ/hS7zi3rTJq1Aks+Ni8xHjIugET1c9sqKSbk?=
 =?us-ascii?Q?o/mqfBYHwPA9JuuriDZTV/dHyOoz3lmVd1Y4pz/WnFd9AhmU7jTTHjGqikRV?=
 =?us-ascii?Q?aEezxzRP2OGqIpD4z5YXMLkYefPUiPsuIISL2MlLmT64VaHWCj/lVcPwekqN?=
 =?us-ascii?Q?By+ppk70Z3/Jra59ks3MlyXeInY8/UGGeuXZ79krA6vIpzOc5Ne3hglEZE4y?=
 =?us-ascii?Q?yUtbfBv6FFfdfuReRq5Dx7crCgJG6IzRI9YMms2cPVNbQoQ3ch884C/EwgK/?=
 =?us-ascii?Q?42vV1jdJN8wvja8zagPt1pPsYi7Y8i9bOHeGVwRJJi3Gfa/CDDWM/VE09dTW?=
 =?us-ascii?Q?EgFSiLGqxRdw1YLTKatKbW2rvWHn4oLrydMc/i601zOHd/bKu/MtvvZ687tY?=
 =?us-ascii?Q?gIQgrPp7pn3G8f0CeCCi+AIbF1V9JLf/kgl7LlK1vbgYQUE7Krex1VVtsQOC?=
 =?us-ascii?Q?dLJ+iCGSBrYjMyhK1WBoLRx5wkPJWIvqB1fT8qYtdjj7RAPLkfM/kXsrvHRf?=
 =?us-ascii?Q?ow4MaKS3+z3yOEW6OVt/eB622G4vd8DYu1NGqptvPrta/T0XUtiIDPJ78dEM?=
 =?us-ascii?Q?RTUZe8Co1pgCzsdqLPIFFnptJU0cgKij04HSaHRingMybqF9PLAbDSmhrkq9?=
 =?us-ascii?Q?/qmpECuFidtVf6Ck0xOG9tFCg23lbKpFYC3bDVuHcRVIzoZkj0U7nwvVeKQt?=
 =?us-ascii?Q?+Alxf4VXkW71GNGj4TGvFRq6wDKYcE0C7pHvPL2um40vIXK01PmVfqsX9kDa?=
 =?us-ascii?Q?bqeLw5jpeeN/+RHOg9V0n/j/gZMAGDF0XzzGUNIKlMK22wBry8vyXgUDehu+?=
 =?us-ascii?Q?ED+qvFHxazvJ8VUWov1NZb7r6L2vUiDHFyTxIm3ma1+I6Ft71Shz3M9nogMe?=
 =?us-ascii?Q?3ZLYna0yEF5qvSFYVLUYKL4oMwXNuY0t43OU/1VRtWkAIDEwo9C1FRXGFcVH?=
 =?us-ascii?Q?mqsIJ7QsKeiGgKvAQRkLvCmpZe6ohVbAbn9n1W3ndtBNHJQMUDazvEt6VyUR?=
 =?us-ascii?Q?faszoIg4jAEWFnTDSoU8YWOZsqTfME7IoG79nuGYmtJ1l+1oNzyKhFFM788P?=
 =?us-ascii?Q?oXNtwZERmyccxnukgQ619SSQfJ0qJUPcA5mh509OcYEFBQ6i5kQ/NOsSsVht?=
 =?us-ascii?Q?rC1UXh/Ltg+rgjXhC7/Q5kHV/QQ19vsjplDV6/nW0jwIxZFFFqLhpkRfaCYg?=
 =?us-ascii?Q?qZIjK8k/JCL9y3CWK4viztDhlVrnpJzOUpMVeMh9rwrpxpOEASUX9FpzZm21?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eea1e8ef-1c0b-44a6-cf8b-08dc2428f0a9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 19:55:43.6263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjTWpWvJ99ElAiNq4Lx7BM9smOrs1XUBbXTRJP0Y60TGy1AdKh/cnnUtZT2Vk3DxaE2uiw8iBok1bZESc9AZNSn+Fdm/7s1HY5JxEmgY+uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6687
X-OriginatorOrg: intel.com

Jonathan Zhang wrote:
> Hi, I am trying to find out how to associate a BDF (cxl_pci device) to CXL memory device file. 
> Suppose user says I want to operate on the (CXL memory) device of a certain BDF, how does 
> user space find out the corresponding /dev/cxl/mem* file? Also between the cxl_pci device and 
> CXL memory device file, is it always 1:1 relationship, regardless of device configurations and
> interleave configurations?

One way to map all these pieces together is "cxl list -RTX" command.
That is show the regions, their memory-device targets, and the resulting
dax-device (sample output from cxl_test):

    # cxl list -RTXu
    {
      "region":"region4",
      "resource":"0xf010000000",
      "size":"512.00 MiB (536.87 MB)",
      "type":"ram",
      "interleave_ways":2,
      "interleave_granularity":4096,
      "decode_state":"commit",
      "mappings":[
        {
          "position":1,
          "memdev":"mem5",
          "decoder":"decoder15.0"
        },
        {
          "position":0,
          "memdev":"mem1",
          "decoder":"decoder8.0"
        }
      ],
      "daxregion":{
        "id":4,
        "size":"512.00 MiB (536.87 MB)",
        "align":2097152,
        "devices":[
          {
            "chardev":"dax4.0",
            "size":"512.00 MiB (536.87 MB)",
            "target_node":0,
            "align":2097152,
            "mode":"system-ram",
            "online_memblocks":0,
            "total_memblocks":4
          }
        ]
      }
    }

...where that "target_node" attribute indicates the NUMA node for the
physical address range of the region. Note that depending on the ACPI
SRAT and CFMWS there is no guarantee that a CXL region gets a distinct
NUMA node from DRAM.

The memory devices are 1:1 associated with a parent PCI device, see the
"host" value in the memory-device listing:

    # cxl list -Mu -m 0
    {
      "memdev":"mem0",
      "pmem_size":"512.00 MiB (536.87 MB)",
      "serial":"0",
      "host":"0000:35:00.0"
    }
