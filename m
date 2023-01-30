Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2D2C54EAA
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 00:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjAaADo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 19:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjAaADm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 19:03:42 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53E5EF
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 16:03:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/Hp0EmfWuY/cqQXc+YFDb8uacYv+mddpaCZnubQp0AG9Gdeh6+iFXGPDpPXcofjrPzeWGEgK1N4e7IWhYxzLp4R9kkmBeXPigi4JUzu6AGYcp1nMOKZgxnx3wT54kjjm+4msd5it5guyEghm9ky4Ss0gO4GXkVk7LQ9kQl2T65LYDoDFl2Z+GwyGMuI/UTavs6L/tZQj8ACGSEOcwc/pQw9uPNTwFW59Wqf7UrxrERqRY65TyFP+lKQEcz6pxFSvmYIBoxYcsIpqQ6w2Ww88U2eEhbpHYxK19NimqVsjQi/A95/bttidRjiZg3lwJwuAoHw+rFSIPx/MHtU/aPZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtC0TEmP9uKQ70a6ys/sSsxDyOM0FOWoPnULYW9e9fU=;
 b=LRpSs2SXmBv190/Uq3oiHSc3Y3lDkPZw7nhefemIX0voc6U5ONMd5KeX+7yQygi3eT0lGz34oY7fB5beYJ80pfrmw6uanYzcKR0fgOqjceiz5/ubotk2kU9C+PJQZj/6e4Fn+mM9TRrM8zgbS2pXqD8wTPErB3uTUdU5jqAbuVeEZ21TZofdjf73ZAdehGtMDqESQmfXBfsn5l0g30rwQqPlVA7pSruXPtgo/B0ub5g8mw3sqhMEkGmpbzbWgumf9tcGETBJRKLZcX62u8ltHx4lTJJeTc7Ek1qg2mjO25e8zNj1SJGyGlO9ob3vF9CME2BqolQtNOT/6M7PU0ax+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtC0TEmP9uKQ70a6ys/sSsxDyOM0FOWoPnULYW9e9fU=;
 b=as/cLpqWlZwunEAq3Jjf2R7S5vYlevVtp5Lq9uGif1VjcdgXGF00yqpbg0qhnmjz4auBq+PhqDNuqvi3r/ktrdv2sxmYNHmUn7/mwOy/LlZpxbVEqtCh2H2eTMHhkQnKDia5t4Zxx/leWp8B6XKIQ9MrZYBS9HgbyFgtQnAL5w4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by DS0PR17MB6863.namprd17.prod.outlook.com (2603:10b6:8:12d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 00:03:30 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6043.028; Tue, 31 Jan 2023
 00:03:30 +0000
Date:   Mon, 30 Jan 2023 17:00:18 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [GIT preview] for-6.3/cxl-ram-region
Message-ID: <Y9g98oSjPo7oxyI/@memverge.com>
References: <63d21ce66e5c_ea22229446@dwillia2-xfh.jf.intel.com.notmuch>
 <63d21dbb62f2f_ea22229441@dwillia2-xfh.jf.intel.com.notmuch>
 <20230126185025.000016a0@huawei.com>
 <20230126193424.00005034@huawei.com>
 <Y9fRVu+yLza4d5Vt@memverge.com>
 <63d8242084087_3a36e529420@dwillia2-xfh.jf.intel.com.notmuch>
 <Y9gva49IPFOXYlkH@memverge.com>
 <63d8504ecaa5_ea222294f4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63d8504ecaa5_ea222294f4@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR05CA0151.namprd05.prod.outlook.com
 (2603:10b6:a03:339::6) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|DS0PR17MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: eb356549-f60b-47da-ad07-08db031e9609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DlRE6Q1TPJHA9y3HRm575dEESmD44N14keUU6a/x8wmcy6s63bkJ03QZN0gNzHLfIKkfxiiX8y4UtYmbnvqzEgFLtLe/C1GPhuAJUD8la3B+6iBYpkLCT8s+VKJIxO9+6Q9lxZ5ooytuQ0rDeHVbJP+uJDDn9yhrj4TRFtOPDVyP6qomTGY7iEtWJ8f3cTmvXEBmBMT7FMpzZIlmZMINQCuzV4ZeulWeHFLi29jeb8YZaCbMuXTwwS+r06AgzK4Iq/tNfIyJrVtYxq35+J4b5ZXsiOyQDPmdXe5F0DxtHRVjGinaKxDpsZ7JU9oI3AY4g9JSkpuJO86XlPH1R25+JrMGeGI6IkEvNNniIg5I1Yl1Ml6FTr+HCCclGPfJGx5ffAAKIlDKVK7JQhMFQF6sLA8Gd9CRojDdEyEZqaTnFHsix5JTSHqYKmQe5JmijuPkxaE5nlWwmte0idaaoZiRcPNcKh2kdGZFfORWkR1Cv6PbHOVUOLyTC7CIVfLsNkhxSfmWJmMTcsKbh+nYkw05DTlJug2swvvZKuX55Ma9yMqa0NP/rXAe9YdNkrJ9rQNg4WNfCS9vHjBRYnSCY8MSGql84Zgh1b7Qh5NSdfPgCYfWPkuekUa1jqVFuq0c1pLeTQpBqX1vNKxFY97NG5JrhY622YwTl29cGEdECDC5Tdc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39850400004)(136003)(376002)(346002)(366004)(396003)(451199018)(86362001)(41300700001)(38100700002)(6666004)(966005)(478600001)(6486002)(2906002)(44832011)(8676002)(8936002)(5660300002)(316002)(4326008)(66946007)(6916009)(186003)(26005)(66476007)(6512007)(6506007)(2616005)(36756003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFNmcGFTblUzR054UnVZRjdyTUxZN0REcjNUV3JEU1RoS2NWVk5kQ29GZjhn?=
 =?utf-8?B?eS9CT3k4QnhQWkk1Sm0vSVBVWWhCRGUwU20zcTVzMVQzNGdyUTdYWmp2RzVK?=
 =?utf-8?B?TkhHMUtLbHBBbU9DbzVwbFVaOENDREpqWU1kWTJJVjNxNkRJNG5mTElNTFlX?=
 =?utf-8?B?YW4yVVgwRmR0Rm01clVHTVYyRFhnOE83QW0rbjRSZld2YjdkNTlMcnU4cDQ1?=
 =?utf-8?B?dHlJVFo0ajBjcm5rZUFzMC82dnBxNGhHMG5ZK3A0Q2o3cktIcDBVejF6VG9x?=
 =?utf-8?B?ZCtmak9ydnUrbG95Z1Y1U1lUWWJDUmhnamRrbkQxdW44TTB5eW5kS29ZM040?=
 =?utf-8?B?cHBTNll5RndQMUZ0Ky9jTndHbkVZWE5VTzVhUWF1ZEF2TFh2NmxQQVgyZm5M?=
 =?utf-8?B?SXhIaDFkL2hQMTZVS21vYk1ZYWpaTzRvOVYzQXZDVDcwSGFzK2dZWWVVT0xD?=
 =?utf-8?B?bVoyQy9rTWRwemtqS3dsN1d6ZnZaY281VldrSXZLN0t4WDVjYUpuQUp1UEFB?=
 =?utf-8?B?aDBWSWhZdWlJTTVsTmZZWTMzeGRGd25idjVZb25OT0oyb2JCalFjWnQxbkVR?=
 =?utf-8?B?VU5SVC9sMStvdFJjSmdTeXZ3TlNiQ2JBQkk5OTBCNldoRm9WektNSmR6d3FI?=
 =?utf-8?B?b0NwS1UxUEkzM2prMzRLVHlYTGVWL0xYczJ4RXdTVW5BbEFOeG5JTWpLT1RX?=
 =?utf-8?B?RlZITjVlcVZnaENoWmx1NzJkTHRnRzg5Q0orTk9mSkZueWNENFh6alBBUE5x?=
 =?utf-8?B?THVwVUErVmhISU9FK3BUb1ZkVW9UMEdNSnlXZVdSdFNoSGw5akQ0NnJ2SGta?=
 =?utf-8?B?dWhCSmZEa0w2ZWhZUDBuTmxsc0NpTGdLYlpNTVZvRm50dUdvbUloYzd6VzJJ?=
 =?utf-8?B?RFEzd0VlRldWdFdNVURjeE1ZcHpLU1RLdGdnSkVQMTR1OENoYU5PbkR4Y2M1?=
 =?utf-8?B?YXRPZk94cXZIMFRoRks0bEQ5dWFlYmZLWlV2QXNCSlNKM1kxK1RJSjFQV1li?=
 =?utf-8?B?UlRENDRrNHBQNHQ2b0VjUk5JdElEcVlrd0JqS1gxVXJtbjh5MWhTajNZRDZW?=
 =?utf-8?B?SUgxZHR3MFNkbU5QWG5tL3B5bTEwbkFBK1FJNzVPeEZmODZ0bXYzY3dvNGww?=
 =?utf-8?B?MDR1SFVUajRidC9tYVI1WXpKNDl5QTBNZUZHK3BRK1BmOXJrZWRpQ2FSMndS?=
 =?utf-8?B?cW5CWjVZZVhNVjFLVXZJL0Jla3N0RldjazQ0RmNNckZ3eXFnUWUwTVA0TktV?=
 =?utf-8?B?QWp6VkRKQVdSR29NUjhtMWRnc3RjMzJkZGJmSXhGSUhwanRBR3g3SWk0bGo3?=
 =?utf-8?B?dFB3YzN4dG1DcThhZ25VN3hGTnQyNjQwNHQ1RWNVWGJGS0xFUW4xNHFVemp3?=
 =?utf-8?B?bWxub2ZvaW41OHVmOEpyeE4xS0tkc2xOVWlIeXZYcndja0xPa3hEbmNXbGda?=
 =?utf-8?B?Qm12OVBJNC9WUWl5eVFSbURrR1JEREhVL0pvODZ0Q2l2UUdTalBxdnljZldD?=
 =?utf-8?B?K2dNSXJaS0R1SEd0MXkzaGRleitiTWFJbElkeWNGVGRrcERWemlLeThHanR0?=
 =?utf-8?B?NjZwd2hsR0FVODhXTC82VG1TcmtBL2pnVG1kN2pOQmpnTElzZitpa1NaV3Bn?=
 =?utf-8?B?aTd5Unp5UC80YXdWVGIxSnBLSjlVekpzL2hGRTQ1VU11QWdrckRrL3M0THow?=
 =?utf-8?B?S0ZxUkJCSWlGYjV1eC9iNjN4VGpsTk9ockM1ekdkaXI0M2ZxVEUzY1JVd2Jx?=
 =?utf-8?B?S3Bub1Z1SzhUNkVwMnRNV0Q3dUoxTzYrWjVxemJ2bERiZ2xrSU1yR243VkNM?=
 =?utf-8?B?N2x5UWdEdWd2Z0VBRjRka0xodXlEblZ6QlZLUkNJVGFtS3h3MlRrMk9XWUhU?=
 =?utf-8?B?Qm1RUU5LZ0tMTGQ5cHMwakdoRWlEV1VIQkpLOHV2TU9xdFhCVjJaTUZETndK?=
 =?utf-8?B?cWZ1VWxHQjVxL0I3Mmp6aURaUGRCVjNTYjZUcS9yTEZ3U0pWNXhHeHZkUjkv?=
 =?utf-8?B?S0l0TWdOY2lubjJ3RkpYMGcyb3BPZUdJQ1pRS0ZjRHEySXQ4RUlEOVozYTl5?=
 =?utf-8?B?RHQvWjZkLzA1WktBTWdHSXp5UnVBd1VReGpXVWM3ZWM1VlZBUzFZVEh2TUo5?=
 =?utf-8?B?czJObmU4VkxYMjh1UmFjc01FQkRrN0VQc3d0N211bHl2VHZVUHZ3TFYydEJM?=
 =?utf-8?Q?RvWl+E45ByDP8AE0gSCiBWg=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb356549-f60b-47da-ad07-08db031e9609
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 00:03:30.6988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxnLJbpDUgTJ56+0m9HXnb3AWP6Gv8QZX5aiANyPMxLJpS/BVZfXjywgu8udhkcPPkDXpETEZv7W/twRrbucTqoIG8Z2h4P2BcJAORXfV/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB6863
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jan 30, 2023 at 03:18:38PM -0800, Dan Williams wrote:
> Gregory Price wrote:
> > On Mon, Jan 30, 2023 at 12:10:08PM -0800, Dan Williams wrote:
> > > Gregory Price wrote:
> > > [..]
> > > > I found the same results.
> > > > echo mem0 > /sys/bus/cxl/devices/region0/target0
> > > > 
> > > > Not sure if bug/missing feature, but after attaching a device to the
> > > > target, you get no output when reading target0
> > > > 
> > > > ```
> > > > [root@fedora ~]# cat /sys/bus/cxl/devices/region0/target0
> > > > 
> > > > [root@fedora ~]#
> > > 
> > > Hmm, did you not get:
> > > 
> > > "-bash: echo: write error: Invalid argument"
> > > 
> > > ...at that step? Because targetX expects an endpoint decoder, not a
> > > memdev.
> > > 
> > 
> > ¯\_(ツ)_/¯ bug?
> > 
> > I went through the kernel code and thought it was looking for a memdev
> > but i guess i was wrong
> > 
> > // ... snip ...
> >     dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
> >     if (!dev)
> >       return -ENODEV;
> > 
> >     if (!is_endpoint_decoder(dev)) {
> >       rc = -EINVAL;
> >       goto out;
> >     }
> > // ... snip ...
> 
> Oh, yes, it is a bug. I fixed it up when I address this 0day report:
> 
> https://lore.kernel.org/linux-cxl/202301281313.kVrIreUj-lkp@intel.com/
> 
> ...I posted another spin of that branch with that fixed up.

gotta love human race conditions, i'll try to be slower next time :D

pulling and testing, and yeah I think what i was seeing was that i just
could not set the target at all but wasn't getting a pass/fail
regardless.

Anyway, will report back when built and installed
