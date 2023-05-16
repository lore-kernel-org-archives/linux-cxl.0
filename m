Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69B2C7EE25
	for <linux-cxl@archiver.kernel.org>; Tue, 16 May 2023 14:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjEPOOl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 May 2023 10:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjEPOOk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 May 2023 10:14:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7B659FB
        for <linux-cxl@vger.kernel.org>; Tue, 16 May 2023 07:14:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6QFgo/voWfvCs3jsmQRisA7bXqwFNRK4cq/MbbiuqLHzLlCX5tIBNWDK4q9sCPCj8HdLn3JmZPcATMy66X9ZkhlBnUptlIK0Hmd0gCx+LmN7JLfZtXcWxWkYq6E4E9NtAtauJo9hAvwLyFtg3+e1WqwTRwZHQdUUwl7ROZ7ZNELcdOpv6RajSBSjlE5Cdpz0//KGh2Boj+Ksu9DTYT5DLy9SZsNN6z3UqZetZjkFwzSUXdIxnVPO4d5Aw4ARVjbyAExkGOC4//+SP0yqzLQ5Sg7YO+Io5iGziMQWYrVzMAeMxo9b4ZCZcYSOyq5PFe9RiglzezmiZTYaWNRFDrEDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2YHqE22gIN1EIGclO7+/P3dKMofeGRXoW4xkxuC860=;
 b=SutvUjVwfws3vn2g+S6FxM7PkECtiLz9KbYxzZ05Y7O/9wvrFBAPtBHqGjk4hKKwoTOnjutyovlM7RLuHfdS61m73GD3lyLKBKec37jS9rtOolc+VElQ5YxlvUol9mv9ZPgaxjuQsk4mJt2rByq7myhHJhrty64icwjIMqK6VobDx28nWkzYQg/ExAYDFf6J2hVYSw7LWwdquDziNPYPBCywY2F2/T9klKIPFWjmXG4nmwS+XcUJ3Ma5ZZsfMTy44w0VqjUzWF4D4LJvIbljuPR0xjv1jZT97qy9vgFKQ7Mgc+miGjSQLjj6wYbyWuNeCzcMbhWQ45MCaDhkf4pYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2YHqE22gIN1EIGclO7+/P3dKMofeGRXoW4xkxuC860=;
 b=gNASGdsgSPdm2u0EydSecML1ON7RYqOAF2eifNMoAjDDBh4rkrPQBna8x0JiXmv2wF/RLFtAt8kf8+59BXaXXLhsCmRhPWxa1EgjCPoNDlCDEz2/nkaJjKG5sr2dZ+0R9p6PfkjEO0jxEh6Bm/kppdUVYWwZjMrftdm+B5WFZL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by IA1PR17MB6215.namprd17.prod.outlook.com (2603:10b6:208:419::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 14:14:35 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%5]) with mapi id 15.20.6387.028; Tue, 16 May 2023
 14:14:35 +0000
Date:   Tue, 16 May 2023 01:22:44 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linuxarm@huawei.com,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Gregory Price <gourry.memverge@gmail.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 2/3] hw/mem: Use memory_region_size() in cxl_type3
Message-ID: <ZGMTJDS9G8iMtW06@memverge.com>
References: <20230421160827.2227-1-Jonathan.Cameron@huawei.com>
 <20230421160827.2227-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421160827.2227-3-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BL1PR13CA0301.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::6) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|IA1PR17MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: e53ead0f-307a-4ba3-ee2e-08db5617e059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nurVswupPT3vJeCVfKET+NtdJslX3v0lh6CbN5/i9OXwjNcgy6JoL8aSGAh3MMDcllza0ceOdgd0fRwoapA/E/74/iMQfDzN/CH7LUlMDcemM1K8rY3Tzpg+XCR4C8XuMgjKqcIunoiGY2lNhZfwc9zmBbp+IIdMdoEigJDn5D5v4Ps53CEOXqpe5jdhbn4Tf+eQR9yqPEcYH2oBpsaHZJHXRReXNLCmGeJYdZUsZHhc9lCM1useeonqCBUbFhBT+oI+0QpcIYBpDmDO86etQf/jp13blldPp/1PDdaTy4SF00kR5zDU9WSpGfw0SHo5eskPgQFWOp62xglu7y2tSOfQIqSdxyZ6aC9bMMSuw4Y6sacvIWPpZvrb7m5YTqOwocsNKzEssf69fxX0YO3roPWL+c7vwig3YYnz1JAYGonxh3eYQTPgZ28rVaB09xnwtNY3DWt5UOUa1wgDmh/MleRRer5gTkHoDCCd6Bjwc8f1DlfH8fX+TCwvgpyY75Iiv3lnZezpDZAaqkR80reqjvr5gaMmNSMyk+UqasAvdFNUVLCraYJCGP0KHAj01/eD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(39840400004)(376002)(366004)(451199021)(83380400001)(66476007)(66946007)(2616005)(26005)(6486002)(478600001)(8936002)(66556008)(54906003)(44832011)(7416002)(6666004)(186003)(5660300002)(86362001)(2906002)(8676002)(6512007)(36756003)(4326008)(316002)(6916009)(6506007)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kLl6MRFFKo0Vfi/g1c5KJILnJ9Xr95os3VwDK+hbl1rxqtkwyq2EjqAFlX/n?=
 =?us-ascii?Q?uTbsWNJYW5S+YCwj4+GX6yWpMJqOuxrwC+Zm+Ur/BAsMDskFbIPTs6G3o5VY?=
 =?us-ascii?Q?nlPNbUk33cB5DhVyKupdTdyfiFKyfLfBJ2gwT4D+sRBiSLResJEZHb2Sh9+h?=
 =?us-ascii?Q?2kfzFuooAq6R5A0YPulN2Z2Nghq6Hs3bSPHU70mBwlrDW7cQuxGlh1NcHOPp?=
 =?us-ascii?Q?XTbdD5QImz4BtugZxtqrtiwi/PH5V8+K0ck7A1Y8l6gPXVTMGu/GYGNc7mSC?=
 =?us-ascii?Q?ITG2agCuxypmgfw424XvBfcsy5ojofVm2vlZutXqX6EmoLpXsgjGBNSZFuPv?=
 =?us-ascii?Q?UWEW02Stc+D+dksJDPfrNyzxxx79MtGxEZ1Xjt3NJHqReFYV9gAj8YjoUjiz?=
 =?us-ascii?Q?5z2m/Cx41dWbaKUJp2oG5F3L3ht1WMFw21iRYYywUl5JDsHtrlGg87cOWY+/?=
 =?us-ascii?Q?5H0Y7ZroBZkswxODVZZRbrr8NjcVjmHXD/0mDCDv9L/50CtQFvxKXnXFQdhT?=
 =?us-ascii?Q?Pz1bRNBz4ySXeYy5+AoypcVUhkY2idRbFYJb994xDNZn+w8LPlZLYOwREfPl?=
 =?us-ascii?Q?HT21Y5Wi3X9ViNVVEHKW5a+srWLsqoBX3/WyqkLRiIh9uxv4UnOW/edSP+6E?=
 =?us-ascii?Q?/ILD/U1F2trB55Pz58zIJn1kWSCUliqINW9Y2KAk6FQ6hL4kJcA3BPxckJmH?=
 =?us-ascii?Q?9oY4VSTL35WWcMtmttS/sHOxLplX0heO60t8QijKbWMTgDtKGOjwPdbi5amZ?=
 =?us-ascii?Q?cCS1kiiicnw3pmjRcgtkS7HQTGBHi5Cc/ntwMWf401BgfIzWo6NOrQ+66kQK?=
 =?us-ascii?Q?BGa35IVh6MKJSN0OmFPOaK5gOQvmPybjOyybhoPmKZw3uEVnJiYmVjJLjvzT?=
 =?us-ascii?Q?tJ8PvMMTxBkRXJD2T/D3YOOcJAGqfWSdqzrqzbfO48ixjlmAcJhfgdZme3zp?=
 =?us-ascii?Q?aW5jg+ooNOzrYIBfHv2EspagFYCBa2BmmPPLTxn99SNh+MiwaYzlfIhAbjqU?=
 =?us-ascii?Q?FlNQDflY9fNlqbowC7KskggPVUuqQPAssffKJ/oZyFqDDSZwMT3zZfHDbRr2?=
 =?us-ascii?Q?J5wl+f7hTLmpoqlmcy5m5mDJDI4Cr3muwwKcRwn57DhtUGUcPl4Sn6J4T/VD?=
 =?us-ascii?Q?b5MVKakMyEy9pCWgUATdKCjC7XOtBBmaHJtY30wotbHtRh3VGA2qvPNcE9O9?=
 =?us-ascii?Q?ya7nF6vWFCK131UOF1mKADqjhv5smm8HvK0ouSsDMP7t0uXSfbRNh4FMH5mj?=
 =?us-ascii?Q?suUlALAmTuIasFoKJ//K17mO2ZTBIw+59o1ylr6rQSuHuNjoGUYMVRQv6Mwg?=
 =?us-ascii?Q?8MJ8dkAw6eplsl9xyCxPDVqLLnhFdXy3DgYEjjXoWzaVoizoUp8NIO/Hj59c?=
 =?us-ascii?Q?CSTqJoqUYqg5LAJj9XRONOjh58JB62cGhsJbWWUDkksXQrJWW+bZx7k6vDSA?=
 =?us-ascii?Q?D0lVQ1O1IWBE6EyQM9gEnRRjvffFEPCjB8XxrValMXZtEbGVFCfZqVh0fLhb?=
 =?us-ascii?Q?KhvgTfIjtqlf9DbPx3nu4EjyPvtOWnCYc5l5q4hTW7pruszRqg2IrvFDTbOL?=
 =?us-ascii?Q?mkrOPtfI1Zi+m8UMxRMduqcqRh9dyjyZxdovX7OfmUBxIkQ5/0kQ/tdPYi7b?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53ead0f-307a-4ba3-ee2e-08db5617e059
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 14:14:35.3914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EAIvR5t1CZahagCG8TKJz6lNaetBn+pAyclCIeSPrOIAjupAf+yP/JYGYhz/H4iNMPU4TgFIdDjvI6lH0r+GBxM8YK7pZe+C/fS4lkhCp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR17MB6215
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Apr 21, 2023 at 05:08:26PM +0100, Jonathan Cameron wrote:
> Accessors prefered over direct use of int128_get64() as they
> clamp out of range values.  None are expected here but
> cleaner to always use the accessor than mix and match.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v5: New patch to tidy up existing instance before adding more of
>     them.
>   - Use memory_region_size() to access the size of memory regions.
>     We may eventually need to allow for larger addresses but it
>     is unlikely to be a problem any time soon.
> ---
>  hw/mem/cxl_type3.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 1bd5963a3f..2db756851c 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -52,7 +52,7 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>          .DSMADhandle = dsmad_handle,
>          .flags = CDAT_DSMAS_FLAG_NV,
>          .DPA_base = 0,
> -        .DPA_length = int128_get64(mr->size),
> +        .DPA_length = memory_region_size(mr),
>      };
>  
>      /* For now, no memory side cache, plausiblish numbers */
> @@ -133,7 +133,7 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>          /* Reserved - the non volatile from DSMAS matters */
>          .EFI_memory_type_attr = 2,
>          .DPA_offset = 0,
> -        .DPA_length = int128_get64(mr->size),
> +        .DPA_length = memory_region_size(mr),
>      };
>  
>      /* Header always at start of structure */
> @@ -698,7 +698,7 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
>          return MEMTX_ERROR;
>      }
>  
> -    if (dpa_offset > int128_get64(mr->size)) {
> +    if (dpa_offset > memory_region_size(mr)) {
>          return MEMTX_ERROR;
>      }
>  
> @@ -721,7 +721,7 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
>          return MEMTX_OK;
>      }
>  
> -    if (dpa_offset > int128_get64(mr->size)) {
> +    if (dpa_offset > memory_region_size(mr)) {
>          return MEMTX_OK;
>      }
>      return address_space_write(&ct3d->hostmem_as, dpa_offset, attrs,
> -- 
> 2.37.2
> 

lgtm

Reviewed-by: Gregory Price <gregory.price@memverge.com>
