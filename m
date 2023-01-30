Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C77C61DA4
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 23:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjA3XH4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 18:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjA3XHz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 18:07:55 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB5229E34
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 15:07:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6siGwhhCmRmQqz/g2dFgru40qhpGthxLHkV7IW70Tqt26GAywZ4K0kVgK4XBndSlrcAJiIjU/svMIkwYaRrVQyD7iNn5qKNB47UXFIeRdkg4cKGZ9KoVGE4DXlEEfeciIjvKKRRCOpnF5TrprgkgRWzGtxkVweer2Eu92pnn34ls4FQPe9AAZmZMxHMEHZxUa9ASiMp2kdps3FFCROJ/5/ObkSKaICAn6KR2CtlnZnOFbgLqnI3F4mdVW9IFbCz3djUlMRBbOOBCMAMAVO71jVNTO+byKngAuYlslqMWzuiQ0e6jATE2mtCp/+ILPgu2l+j7AjF1QrtBjl8F4gfDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mV+SNR9ZwhQYLX70cqVo+CpHwhy0yByaeSWkeimiO64=;
 b=WAqLCfOMFVlYLFwC/dCFnwlqourK3RU0cQ8CrYgmLI9a+t65urX8kYpSZoteKMBrY+dHiTBp1ojS90QiEgK5ugdGryBZ1oQiE53f7E8jqgkho6UWACwAhEu4rqbnWE9pS5CVc0UTiSK1WpjItLEA2KwcIh1e7FzFHpx084XCMko054FCdUbFpE6PuxoDkebIGWZLPuElwIt3E/0Yl3TOtw3fXfYiZb4sfHhEmyQVrlhO8cTEn9//KsvQRgeCF2KEWuGcgw55TzeJ2/60B2lb0OY1WdLjsicK/rCglHI98n0WkQm/WHCFc4QWJVzT+5sgtHAB9MNuukwQKUsIcWKH2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mV+SNR9ZwhQYLX70cqVo+CpHwhy0yByaeSWkeimiO64=;
 b=vHXCAZeLfscdZa0R9ycMAQ5PC1/c+Ss7v6B5DMoNgG/xLcmaF9P9zpQxxYSQl4OhsQ4gzJweeCrLTKO/2QZMwqBHg7HbSGcGPvLL3c3v5gat+uFOrijMHQP47T8aA+q2Q6tcQiHC+t0x5LCzoK3mRs8YCvaPaN9NGpQvR9QN1JA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by PH0PR17MB5866.namprd17.prod.outlook.com (2603:10b6:510:119::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 23:06:21 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6043.028; Mon, 30 Jan 2023
 23:06:21 +0000
Date:   Mon, 30 Jan 2023 15:58:19 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <Y9gva49IPFOXYlkH@memverge.com>
References: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
 <63d21dbb62f2f_ea22229441@dwillia2-xfh.jf.intel.com.notmuch>
 <20230126185025.000016a0@huawei.com>
 <20230126193424.00005034@huawei.com>
 <Y9fRVu+yLza4d5Vt@memverge.com>
 <63d8242084087_3a36e529420@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63d8242084087_3a36e529420@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::26) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|PH0PR17MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 5116f8e6-9624-4075-b8e1-08db03169a36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x5pXs6AHY+NQUtPoVa+tHQks3qoFJD8WeR1IamTSQNf5UzkJkmCV5kR2RXU8Pa5shYSrn97KCsq+5F7J7UZvtIP7IX7iXkRMt/t1dj0GNBfVxeWS39NqA54/YGPBe+tAcE4gxLTOcW0Ibu+dtAMz9ih4n49hJGWrZsQAExdSrJdeYr3lbDdCBVgXBkZRq0ulHt4VdqEpMiKB7zOoKSWz7mbjf5KZMt1fIAWR/F70vXhETyicOH3qHh5sQzY3Fbjb+FGJhFUmL9mBEUe5T5P1s3zggS+uFT1dvkFI6n5tsAIqpKKusfRPjtlAq2XBBHflpf79w56EpNNoY0dm6zgHZDqOGtzIYZ1B6FNTLNpG/WiqtQOiHwjP2I1Mz4zre6Klt4IaLxBbdmq7aTnUJ9WYXFyAWioPAowY/ciiTaIGKHI5KyjymVSdUin39UxVa6WE6wylVseZmWzMUPDezhk6X45u9yWF2vGIeTkhJjeChdRbcqpBKo3uDuLImTCMqd6v2nFPzpHa4KLhgn9LzbkUTGdu25BcZWOz5l8sbgX7NZiLMzAx9VVyuow+1IjCR6uYSLyhSM7kqaeHr6Qzt0cEmJ3tFO6DM9+04YnO80IwDwGYx5NwQ3e+Jw1Bj+SyISb6rCPjH0CzbGJlNkkYpBMjWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(39840400004)(376002)(346002)(366004)(451199018)(2906002)(316002)(6512007)(44832011)(186003)(5660300002)(6506007)(2616005)(36756003)(26005)(38100700002)(6486002)(83380400001)(86362001)(478600001)(4326008)(66556008)(6916009)(66476007)(8676002)(8936002)(66946007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzFIVFlWTldxS09xYjc4Vk5NMmcyeTJWcXd6R2tMZWRseVR4YTloTXhUQTN6?=
 =?utf-8?B?RkRaajNobU93YzNkVEhRM0IySEptOHVZcnZaMFdWZXNNZEJadVNBbjVGZVZY?=
 =?utf-8?B?OU5rS3FtYTFjdTlJL3BaczIxVG8xSDZYbHd4TjJxaEI1amF5amQvTDJ2bXdC?=
 =?utf-8?B?SmcydFJ6Y014T2ZJdCt2WHBCcXMzSlFURDM5blRiek1oWlpHWUNGaEc2RGh1?=
 =?utf-8?B?Z05zVFZTNWZ4Q1hUcHVONkdLb3I0TDRPVGY0WVc1Ukl3akZoTytMNTJtczhr?=
 =?utf-8?B?L3ZCYmFKa1FsRXBydmJxaFRNck5VcWYvRVFNdlhrNlluVjYxMEhOV1cxclBy?=
 =?utf-8?B?U1FaQmlucWdkaWpFeFpnY2lBNVRsdHVXVG5xdFgwdU5mQnlhYXgxUWNoS3dJ?=
 =?utf-8?B?MDVYZ1NvM0MzcjRRZnJ4N3g4MHZFNEZtazZjRHkzTW5aalNOTDBxZzNPUFRP?=
 =?utf-8?B?VkZHSTY5M1Rra3l3aWhzc2RvT1B4WkZHcHJOMVlJYkJTTm5ZbUVWZUVnaTJl?=
 =?utf-8?B?QklSeGN2bHBHb2hRbG55QVQwVUhraE91eHkxSUFncld1RmU2TXVGcU0weklo?=
 =?utf-8?B?TkxTaW5BR0hlZjFCZ01udks3RTcycUo3bXZ1dVVMTEhrQll4QnFYWHk0aXVN?=
 =?utf-8?B?V2l5UExHSCt1emUxZTJPUE1WQlYwL1hiUnF4ekpRM0twakpIblY3UzlZcURP?=
 =?utf-8?B?UXMwbjA5VXVsck5XTXgvRGFhSXE5MWgyNDFlUXRYR3ZIQWlaMHFJZGdnTVZY?=
 =?utf-8?B?MDlqVmxITkpWYzh2MGhydm1ETlZ1cS9HbkUxYmxmSHh1VHlVL0dmeWQybkpu?=
 =?utf-8?B?WTdkWXB3NGFqanhXRzNkTTVQc2MyYmJ6WEpJdFpPNlZuNkp6QnhHajhkZGpu?=
 =?utf-8?B?MjdMTERjNlZaR01TcHZxdEg2cWRDREY5Q09qaWdpWi9yanI0VEliTTZiZFFL?=
 =?utf-8?B?S0NhT0R0YnlMVGlMR1drTVFvNDRyOEZhcUR2SEVYaFRPVXc1NWtwQ0E0TDVF?=
 =?utf-8?B?alk1eUFVY3cvOFlYcjh0WWNtRFZJb2daeUZCdlBMS2tNUFluZGhyYzVkdmVT?=
 =?utf-8?B?ay9JQnJrZzdyMUNrRUdqeGxObGpWMGZiZy9KaUJWa3ZSS3Q2d1FrS2UzcnNn?=
 =?utf-8?B?U1hCQ3ZWdEoxT1JFV0NzcVc4cVV4M2xxWDZwQ0ovOTRmbVRZUDk4YWcwcHJM?=
 =?utf-8?B?bnRTU09wZkV6N3kzY2Jiem9VWHBnOHlBTlU1NlQwSmYyTVdDekkwanVJMEtF?=
 =?utf-8?B?Zmd6T29PeWdTaHovZU1tSm1NS3lzUlNlUDFzZTBpYUJrMHdMRmh3Vk1CVnVa?=
 =?utf-8?B?bWlVaFlIOTg2SjUyTkp3cTZkUkhqRHJUbkJLNVprQVIrem5OVWFUNHg5ZENZ?=
 =?utf-8?B?OCtuRnVqcFVQV094d1VDZVBsNHVjQTBoL0IrRDFkMFZKcVIya3NSd1BYYjJo?=
 =?utf-8?B?OHRWRGU3UTdicHBHdFNZeVpxZVZXdHNkVjZ4TnlabkJESGliNzlOQnc0b1Aw?=
 =?utf-8?B?REdyM2hoUXp0YVhMbU9pMTJaUm5kS1pSUCtpcVpQWjVLVjd0cC9sSU1xU1dP?=
 =?utf-8?B?T0tBZlZZWkNvU2d5R1JhcklRRmhsTlVxVnJpTDAzMDFhS1NGREdHdDd5WG9L?=
 =?utf-8?B?SVcraFMrVGprUXp2YmJsWVBhNGo2VzhsazhRMExUdWRSaE80U1pDU2ZqSkph?=
 =?utf-8?B?eGkwUE85T0czbHlHQVdjSnhkZ0Y5ZVB5dFU0YTVvM0pDWEE0UXdxOGEvWi81?=
 =?utf-8?B?V1c3Z0ZjSDJVeFZkV2hkOVpQNXpDeC9qUHEyNFNhUU9MbXh0bklEUmVjT3Nh?=
 =?utf-8?B?Wi9JdjBRQ2Y3Qmh5eXZFNGNyR3NhbThlVTc4OTQ2aiszYmVTRCtHeFFQYnJO?=
 =?utf-8?B?N0pOTklubDJ3Zld4K0dnMm9pR0xnZFBkWU41Um14UU1RZXhhS2I1L3RDZ0Vu?=
 =?utf-8?B?L0ozdC9SVCtWN3RnNVNwei9rdjliem1UdXBSTEhBVFRTazh1SFBkWE1yNVM5?=
 =?utf-8?B?NnExbzNhRUFrWUprT2xvZnpXNTVTQ25YelNSanZLMzc5WFkveGpnT25DTmpr?=
 =?utf-8?B?SHU3QTBycmxxNEZUU2pjMVgzVjBFQmZkS2dqVXU2Y3VYTEtRL0VVd0xLeVNs?=
 =?utf-8?B?RjJoUUx2WkJmWWFkR3VxdHJKYUozdnZKY0tOZjNQRUM5dC9UWG9TSXRKcllM?=
 =?utf-8?Q?LRD9azZJpnHIfyBWAVdwPGs=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5116f8e6-9624-4075-b8e1-08db03169a36
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 23:06:21.6373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRZ1bd7bfVO0qP7gHEr6NhlHXENqoUl+9JELEV0njrtK1N/7/qUY0kpcx2/jTNeg8Hup6dKdrYHgC8yPOcLdw5sjvpZkvtKLGTDEi2/B0qU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB5866
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jan 30, 2023 at 12:10:08PM -0800, Dan Williams wrote:
> Gregory Price wrote:
> [..]
> > I found the same results.
> > echo mem0 > /sys/bus/cxl/devices/region0/target0
> > 
> > Not sure if bug/missing feature, but after attaching a device to the
> > target, you get no output when reading target0
> > 
> > ```
> > [root@fedora ~]# cat /sys/bus/cxl/devices/region0/target0
> > 
> > [root@fedora ~]#
> 
> Hmm, did you not get:
> 
> "-bash: echo: write error: Invalid argument"
> 
> ...at that step? Because targetX expects an endpoint decoder, not a
> memdev.
> 

¯\_(ツ)_/¯ bug?

I went through the kernel code and thought it was looking for a memdev
but i guess i was wrong

// ... snip ...
    dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
    if (!dev)
      return -ENODEV;

    if (!is_endpoint_decoder(dev)) {
      rc = -EINVAL;
      goto out;
    }
// ... snip ...

bool is_endpoint_decoder(struct device *dev)
{
  return dev->type == &cxl_decoder_endpoint_type;
}
EXPORT_SYMBOL_NS_GPL(is_endpoint_decoder, CXL);


notably, memdev's do not expose their devtype, maybe something overwrote
it to be a different type?  Seems unlikely, but i'd need to attach gdb.

[root@fedora mem0]# ls
dev     firmware_version    numa_node    pmem  serial     uevent
driver  label_storage_size  payload_max  ram   subsystem



> > ```
> > echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_region
> > echo 1 > /sys/bus/cxl/devices/region0/interleave_ways
> > echo 256 > /sys/bus/cxl/devices/region0/interleave_granularity
> > echo 0x10000000000 > /sys/bus/cxl/devices/region0/size
> > echo mem0 > /sys/bus/cxl/devices/region0/target0
> 
> > and mem0 would get 4096 memory# blocks (presumably under region/devdax?)
> 
> At 1T of size, mem0 would be hosting 4294967296 256-byte blocks.
>

Ah i thought granularity was in MB, derp derp.  Note - that's what the
root decoder interleave granularity is set to, so i just mirrored that.

[root@fedora decoder0.0]# cat interleave_granularity
256
