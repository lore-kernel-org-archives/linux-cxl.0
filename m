Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1952AC61DA4
	for <linux-cxl@archiver.kernel.org>; Thu, 23 Feb 2023 22:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBWWLl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 23 Feb 2023 17:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBWWLk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 23 Feb 2023 17:11:40 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AAB5A3AE
        for <linux-cxl@vger.kernel.org>; Thu, 23 Feb 2023 14:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677190298; x=1708726298;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=v/93g1O5+ApTquI6KlkQUCQpWxLcPRkURW0iMO5ZNm0=;
  b=RW7bda1z5RZDe0F6EKa+fZ7czftoDf/jwwlrxoabLqT4Yqu5lJ6UrwFV
   x47oJZSXMxhTi6EsMvxpYoPzwUrHagvmdetU5slloM4GQkhNDdOqgg2ye
   d32mAWNSVQHM0TlcUMxbxxO9TtQjW+roL2ofUE4MtFoxZ6QKPWMW4CO5d
   nIzdYq+m5ZDBUJiKpckEPXQfhXOYzJAXSDbturoOxagcDRFGkwudSu60S
   /5b4RmcfzSVAsDk8oJLFyUyLFM1hBKTmlwgFy3wVP2B9d/c+UwxplUhQ5
   o0MpSXxhlXH0hFcdn16/HfUwdeWVt9682vWJdGoTsjiLJfiiOSs7odYck
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="312971695"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="312971695"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 14:11:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="672676896"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="672676896"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 23 Feb 2023 14:11:38 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 14:11:38 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 14:11:38 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 14:11:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKOcTCwMylDT5tFQF+ymS12a2xZus/B3Lm0fdsJyEGoSoMNYPyZJm4xZqrZEnWwFygSk96Bd5etuWbAjzmNJUkxa06yfcAnp0FHEJtRaUfYPL8nwosJfXSSfgXxN3ctztQPh3MHtSdkjPIm8gE/uVDCPcKxfFIhQAzuiGnUtqbnMuH9iWWZwq/WiVyiP6CLv2C1gZsMbhS89uOzij9q86qAXHs+bobQXYpam88uFvpbBH6qkc0zvstr4ih2Se2ZywA5pu4XvpJg1FLlPjaoMioMfxvxSkqQ0FmxRO3vzTbqOQt9Dl0qF7POMmNEVBuv0o+pehTTc7kWHVA6g+7werw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqOCwvHH9nUE11K4apPLkFsZneAgTauV77op67k7ITs=;
 b=d8GudqOCtdlUxujGsJ1stqN8IVtWjnOdyM4V5ZvSAApYOwFjy5ie1L7BRbfafTVGDYJ4vTD5f2MPLgjTnYeOtKrKmVKydc0F2FhyuXiMshsfyu2LWBrG0V3HIWrfZSidEiA5EcnUEvhHj0eZTB3Lr3jlcUaesBBEKwUxYe9c8pHeKeAymAgDORb+JlCYhPjhEHFaboZY+Xnoc8hTz2oJW+PtO4dMTW1C3O3+F7ULjJAwnXLsmSxGdY1+iSQltu5+5t8U/Gloczl/lACoHfrNqM9rDZ9magIj1W037MTaWltpNDBaRHxKMNYPiJyCy8nhjeT/Xz0HXqugV8FqcZqKzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5792.namprd11.prod.outlook.com (2603:10b6:a03:425::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Thu, 23 Feb
 2023 22:11:35 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%8]) with mapi id 15.20.6111.021; Thu, 23 Feb 2023
 22:11:35 +0000
Date:   Thu, 23 Feb 2023 14:11:31 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Nabeel M Mohamed <nabeelmd.linux@gmail.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2] cxl/pci: Set the device timestamp
Message-ID: <63f7e493394da_20753229444@iweiny-mobl.notmuch>
References: <20230130151327.32415-1-Jonathan.Cameron@huawei.com>
 <Y/Y19p8hqgYGkkKK@nabeel-linux.myguest.virtualbox.org>
 <20230222162700.00006d0f@Huawei.com>
 <Y/bjnb0gmmpkjk8r@nabeel-linux.myguest.virtualbox.org>
 <20230223164227.djns4grt3qeydmn6@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230223164227.djns4grt3qeydmn6@offworld>
X-ClientProxiedBy: SJ0PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 870e04dc-83c8-4621-5c10-08db15eaed34
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zXo3i16tc6fe9bU4NGSUuGG4VfrX9/IndnOY4c6xW9Lqx7BJCK1he/3vDQLr6zWs547Mx1mK7Qy94PfQfYuV6Exvx/Z9i8+xK02r65EvsaemM3r0aU7rhZjWj8Elc/MdYGRBtJztMcVhRVm9RI0CgMQ/L4iXShhCFKEDKmwYYJh0NneGGrmV2jzmFDUHu5KN5a+1/GusNPDNBbiQhs5by0hwKajcPnAxSUFVDaLffBKvia5wAURRz9+zQ38553Fuh/4G8KrJ9vsqvnsKIMa9lQ+8UEA1YMDR3fzSFyUxvwbcNXeQ3xHsGlqtvgiyAunzZYL6sZhIJvpw7lUtfuBE45wYs7QWsxv1Tt1G3SrhJHngj7Vd9UR2K/2FdMTtZSyQA9AFE0yRPUtbGdD6li93yUxH2jFIrIS4XgYv1gHTivlw0HrfLZqbVgglCC12dGrfsIC0juvetn7STX809xEx0aCeFlu5Nz9wMSTjCFvryuQYrDUqQk3go7IKsBkbl7a9mVznBQlWkggB/+YbxED5soF+qz6jCWqXrQFTeKk8V5oz1IzyicQtkdVZ5Iv71s+ND2oaF5rR7STsw7oZZG9bG+hgdYBfHDjqvNEfx2Alc/KnK/aaGFhAW69lsIZRLUxvr0suPd//qVsKWIwCfldbAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199018)(82960400001)(38100700002)(83380400001)(86362001)(44832011)(54906003)(4326008)(110136005)(8676002)(5660300002)(8936002)(41300700001)(316002)(478600001)(6486002)(6506007)(66556008)(66946007)(66476007)(6666004)(9686003)(2906002)(26005)(186003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uYl9E85zIQf1K/olZcK+8Rbjajwafs3SJBSGAIRs90x/p7aiVkwjqcK6lI1W?=
 =?us-ascii?Q?rsv6KAaR6A0Lij7fY7AVH0a8Ifa1/ULQ4Ok1xzoL6lEVBDbh7GQtxj9BOLBK?=
 =?us-ascii?Q?xOr57QqGmsvbo6boX09UMAdnircnLduCKkqf9j6Xk0xbztGUj8E1c3repzbw?=
 =?us-ascii?Q?24W0l5ayGlLmMxePpA11wWDYn1Me/CiDkj/afJ/nmpLM4J+4jTxMy50HEBrk?=
 =?us-ascii?Q?QVXXR+x7L9pmCXVKn4vn60kwp45yoEhrrnJb+euoYnZL0sR5V9aYv20PRgrt?=
 =?us-ascii?Q?Sk9tPnImEboN8RVn7s/C65qktaaECvjzifMIVG/qSgIGVYH5XIeIleO4k9NI?=
 =?us-ascii?Q?69aQNs2x6xBXh71giMQEj2z/BoGn825WXt24PUZmaqTxvwSW49oLmAXySzoU?=
 =?us-ascii?Q?AwONs/Zutx0v9OFnfHG+81f+cFKpUlHzk1sXjjgjEeQO+3JfoVIcKFs4ahVs?=
 =?us-ascii?Q?08Yz+OUOrcMhHXc3ye3BvLeQ1m+LVwwKgui+9nltz+mZjUT8JJQt8dmqAsyB?=
 =?us-ascii?Q?quoMfjGsPe3I+X5RUbMk0JVdqB4Ext64yBd4mD6M8Ena7gXQHBP0fFj2K3mt?=
 =?us-ascii?Q?74IaY/MKvTYq+Xz3bqjRY0G2Jca9bRsBfwQSYITQjCYb1CwP/aEW9L0tfrO8?=
 =?us-ascii?Q?xcjI7+IrVU2NZY+9tyz8lV+h+hfSI+sb+tCQ7v4aPTpEuQVyX78gIutknDFf?=
 =?us-ascii?Q?uNS58IdYeqWADxLhlGgpqDWk/Lnxnu4ccRV6JBg+osI7/uaCCci3U6a8KVZ8?=
 =?us-ascii?Q?aFwJEQE5JDq6Y/hQPf+06v1KHYkBMppkVf8q9VvbH0kz1En0/D65JTPetk/G?=
 =?us-ascii?Q?OBb4h1e+9uoHlJ44Zy0+8oTtukiW7HFFjppCVGOe2HZE+WcxA8g003UgIowv?=
 =?us-ascii?Q?3TJo1EOeWpEMHvec2q1cj63KbL7mcTIGGnovEmyXvtZ3SnipIiEHqWjzfmOK?=
 =?us-ascii?Q?XZocxjyBAgGSk1sGsUwIq4UvUoY+DmAss0sv+3dKh1tK2YVIL6Iwjy4tWQYB?=
 =?us-ascii?Q?dZrFgYnJosKbxh3UMF0Wdr5IzT5tBSRUE+CUGBnfEVDYyP0jI3ov02VQmhYc?=
 =?us-ascii?Q?QXDvkZiXX1Cm9HBp6G8b0kKEpRwM9sg988hLKirAc2PL3m9bzL7q8Dup67ki?=
 =?us-ascii?Q?IRnv3oivG+kxg8WEsFpjT7C+J+wsuebOoQn3tvHok74Qiww9zI6Z6l9fyWfG?=
 =?us-ascii?Q?bFLWUE1eRQ8jpq9KRQvTBd60OopaGiceDqcuDjMaUZm4t+C03qwSjWqIdESA?=
 =?us-ascii?Q?o3fEj3eZ8cxPNXvBwyjSLjjpIpHPdAh0EYqYAdQA9q+ydwFFocwQruWViK0C?=
 =?us-ascii?Q?fr32dDBdIB6VNifk4YVQv1wF7YcEwsobBtwixQ4yqRIaAROELNDnwS2uG+rT?=
 =?us-ascii?Q?oInYSVZGdLd/SGgXwG5rxaM4NmeCvZGdtNvKIwaOmBQJwJiNEr138J2Ili7c?=
 =?us-ascii?Q?RukxRlIjDWSIAHAFH+17zO+2boMOCtTVYB1FkwJsUrLIVIl/jA18taCvl2uF?=
 =?us-ascii?Q?TdwuZvCByo5KfgudwXOIUrviRFgvqj914mUSCvp5bEtAJy3YTLqVqftJauVe?=
 =?us-ascii?Q?0+UaRFydtZHpxgMKBCCGOBrDwuflQVnpWnXKbRpi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 870e04dc-83c8-4621-5c10-08db15eaed34
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 22:11:35.1419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IANdutusyqvuaPEWckzcNFPhRI0clBu558f6GQuI81RlU1COyNcb7IEWqfeRSpJ04fjnLYGkq//iW8RFiwU7Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5792
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> On Wed, 22 Feb 2023, Nabeel M Mohamed wrote:
> 
> >So, I'm wondering if there's any checklist listing the prerequisites
> >for submitting a patch to the CXL driver - for instance, requirements
> >on adding new tests for coverage, any existing CXL regression suites
> >that the patch must pass, etc.
> 
> Btw we might want to support timestamps in the mock device, no? I am
> aware that qemu has both get and set.
> 
> --<8-----
> [PATCH] cxl/test: Add mock test for set_timestamp
> 
> Support the command testing in a unit-test fashion.
> 

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>   tools/testing/cxl/test/mem.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 9263b04d35f7..09511f2fbe54 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -98,6 +98,7 @@ struct cxl_mockmem_data {
>   	int master_limit;
>   	struct mock_event_store mes;
>   	u8 event_buf[SZ_4K];
> +	u64 timestamp;
>   };
>   
>   static struct mock_event_log *event_find_log(struct device *dev, int log_type)
> @@ -361,6 +362,21 @@ struct cxl_event_mem_module mem_module = {
>   	}
>   };
>   
> +static int mock_set_timestamp(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
> +	struct cxl_mbox_set_timestamp_in *ts = cmd->payload_in;
> +
> +	if (cmd->size_in != sizeof(*ts))
> +		return -EINVAL;
> +
> +	if (cmd->size_out != 0)
> +		return -EINVAL;
> +
> +	mdata->timestamp = le64_to_cpu(ts->timestamp);
> +	return 0;
> +}
> +
>   static void cxl_mock_add_event_logs(struct mock_event_store *mes)
>   {
>   	put_unaligned_le16(CXL_GMER_VALID_CHANNEL | CXL_GMER_VALID_RANK,
> @@ -894,6 +910,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
>   	int rc = -EIO;
>   
>   	switch (cmd->opcode) {
> +	case CXL_MBOX_OP_SET_TIMESTAMP:
> +		rc = mock_set_timestamp(cxlds, cmd);
> +		break;
>   	case CXL_MBOX_OP_GET_SUPPORTED_LOGS:
>   		rc = mock_gsl(cmd);
>   		break;
> @@ -1010,6 +1029,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>   	if (rc)
>   		return rc;
>   
> +	rc = cxl_set_timestamp(cxlds);
> +	if (rc)
> +		return rc;
> +
>   	rc = cxl_dev_state_identify(cxlds);
>   	if (rc)
>   		return rc;
> -- 
> 2.39.0
> 


