Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2413AC6FA89
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Sep 2022 15:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiIOPz5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Sep 2022 11:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiIOPz4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Sep 2022 11:55:56 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E588E99E
        for <linux-cxl@vger.kernel.org>; Thu, 15 Sep 2022 08:55:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRf4cbD8ErGr8M0cPSuEzIZNMiEfi1KzBvVNt+wGi7Dt3naDmfYBXZNKR0yJyaN1HDwQLEQtXI1o/Au3nyTVjdt3zRagqeOUh/bceXJftX49lGZxf3Kh38CPR+TCo9Wty7nIjs+Q62m3yaBDCPUL/Eu8xoN/JW4nT0vgsNUyqlTJyeuYqtEFGdl6BQwNwY345DGY/lzdCdqbKbl2bo2KAw49wZCRuk9JVgrR9uBBKIMKg262AQQOEROjkMkWjpjR5Sb3q51FI/m5vbZOhQNJvwSwIpmpgv42pRGCFb+LzcM7MCOe9HTBuUfX31sAkUFu0fnMwUkO04kLFSN2TJS7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YOqlBpth3BkctRxIwJNu2TyJqgAChfJQZOwy1oGN9M=;
 b=Nu6ScTYWVYD78P6BLWKZP1ITyRvK7EqQcFYo6JrWz3vaI24/eYEC6frjXKXoJOnj81u5MQHwdPNRdIftclSjt5nqTXKo040RuUCPe9Z6b6Y4fXs5oupbnG93/pB4sq5+BjS46TBgi7JbeAjNIZTBT+xRD7AA2IGDNVfbe68UkbqzBme0qnFy+tplL3S9fG1/VxpehUvqRUN2gPpaw+QQt0BmlY8kTrZIjIEhnSg/NkYE0417rdk3g8w195IipCV8/Qc0mF0MX0Hh8Zo+odpUa530CcFfpkEGQHBSiHj2aUPf2dh/qrVK76yC4SZz3l9Re3+PEsYjOFQCD96hS9vTqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YOqlBpth3BkctRxIwJNu2TyJqgAChfJQZOwy1oGN9M=;
 b=fDe4hjT4ErgRLqu7cbD/iXQYsCfCEaJOP7PXGukwIyn9eM8Q8cNzZJVd4FEw4TcxZGoopXRzamMwj51zxadodjPWLfSvwupcTfXKP9WapIHgUW83b1RKphUcvWcx6shLs9sm6tcyoN1r1upzvc6g7CbB+9Gf7Vs2Qg2emthJysI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by PH8PR12MB7351.namprd12.prod.outlook.com (2603:10b6:510:215::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 15:55:51 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::dffa:5a91:e628:96cc]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::dffa:5a91:e628:96cc%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 15:55:51 +0000
Message-ID: <40400223-a228-457a-e65f-61598dfa45c3@amd.com>
Date:   Thu, 15 Sep 2022 10:55:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 6/7] ndctl: cxl: add logging functions for monitor
Content-Language: en-US
To:     Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
References: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
 <166318850459.3087953.851045527272435004.stgit@djiang5-desk3.ch.intel.com>
From:   Nathan Fontenot <nafonten@amd.com>
In-Reply-To: <166318850459.3087953.851045527272435004.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0039.namprd13.prod.outlook.com
 (2603:10b6:5:134::16) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|PH8PR12MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c61438-dea4-4da5-ca41-08da9732c3b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gqmwBZx9nY5IRmYFtWjV5a+w43c/wO7qSiNCj9zCKFxzWdvtFO1NsvoWfI16ZHul377BLN4YLrMPHpRPbvaXkZPrHadK3wtkyyzmFdJdcjB9Wu/NTH6cYsi4jCfJU0bIu6g9dZTQlDT3SWsp2+ibGL2xW4Jmm2k51O32QrPspXPTgjnXcYERtmAopnjh53ahYRyaJU+3N5rWlbs7CT+JcJ21uoFpWTbgNq4+USwQ99fHab18EZuLS9ExlzGrtGb7dagYtcm3kQSO2lt2+/b8Msy1Sj3F3rzEcYxMRrjpXD32wIUGO7bdNxFUbmnuTvmlAxeUkYmDXKiNOyJdHyR3bd5nk5k/KdAvO4MLsfmxCt8EvWBdoYACm3JJJrr7a0S4SBd/pIAQ9F+Lg7WCPVuuv08/GD+NjJja/ynMKieZO6nBDclcnGvp6IzZevubEi8WMG/IXKSHHv33re1HiIOHdoGlQXcAlGgQRPTRUchS5upXYyTatkhh70r+b4K9+jYzIVsIBrKwd1yQQFCOFcLxdWQnozFf0QKJBw25I4Er/JemzBM4rdhqhPdhEkuLDmiUio+55phefWIo2zObNeiWreUg7S24zYCmcbmHXHRAbS0BirjljcCE71Edg3Sd1vKLmg+ywvPXNHk4uoUDoeaJqkJH0eTb8L6Pnp98ms3IYH3YyAhwS9nQ8+0v1wW0L3HxB5jyLX0Ay5ViWxzW17SqhiWB6nGOB4g1buNT15O4PNxbvNdUtRLo5z/mVSmaE4uh+0A8/K5wGvAC2Vk7U4UC2sosFFktW9jQlZ1N8J1yzog=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199015)(26005)(31696002)(186003)(66946007)(66476007)(5660300002)(316002)(31686004)(478600001)(36756003)(4326008)(38100700002)(6512007)(6486002)(53546011)(2906002)(8676002)(41300700001)(66556008)(2616005)(6506007)(8936002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUZ3N0RLdFNUM1VqWU4vTGpCV3A4aTdZcGZ6aDZzeWlIWmlWM2pEYmJKTDJD?=
 =?utf-8?B?b092MUhWVlZhZ0R1SGo3QXAzcUtwYkFxM01WNENXcjlKaUZaQVp0L2F3djJ0?=
 =?utf-8?B?UWR4a3M2QTV0MTh3MmVGSVNBNythenRtYkY5c2wrYVc2NFhmblFRdDlZdzkx?=
 =?utf-8?B?Y3c5V3I1VGpSTFN1QVlGd3BMbVNqeFE3a1VhY0RsOUorUm52YmlLRkRGMVEz?=
 =?utf-8?B?UnRHTHNka2lvZlBieXBRTEdMMDI4WXpybmZaTnFRbG5oaHMwU2dpenJGVmp3?=
 =?utf-8?B?YjZ6WkltaXJWa0FOMm1nSEpYWG56NC9JangwQkF6U2swY1N0bTBiNy9PZndB?=
 =?utf-8?B?a2FXM1YxekxwQzg5SjBEZUozSTlGZjdxanBDV0YrYWZ6RVNpNFZNMEdhVEJN?=
 =?utf-8?B?RUFKZWhMcjI3dkgyOE44NXRXMGcrWHpOZThiOVZPbmVzQ2lRTzRGQTdzTmxV?=
 =?utf-8?B?OUI1UFd3Z25qZGpOc01uRFlxOTN4S29VNXRHRjVUN2ZlMXVJQnFXVlQwaU1a?=
 =?utf-8?B?Qm1wenBBdkRvMXRiSEYzaVBXaUVaTTlUaUNNUGpncXhHL3g5SWlpbTU4UFpt?=
 =?utf-8?B?M2ZHclJqaEFoR0dEQm5pTlI5bklQOGVScENlKzkwNnM2UW05bTZTdGE0RlJN?=
 =?utf-8?B?SWN6ciswaENQbndEY2I0Uy8yQ1lHaVF5aE9wY2p3RFZiL3RCQVdjRjFzTWNu?=
 =?utf-8?B?Q1dOL2RuWllqOTdqa3dZSndWZGNlSVRwQTgreWpBbGc3UGgrQUxIZ0hwa29w?=
 =?utf-8?B?Z04xWFp2dC9mb1pMQXdVeHZ3NVEwWlZzdGl3TC80RmttVWdLOWh2TzVIVHZk?=
 =?utf-8?B?VDd4KzFQRWJ0aTM5Yi85M09nWmRQYVZiK2xhdy9NM3pvdGpTWUtibDFDOUVj?=
 =?utf-8?B?SE5oYitqa2pwNTNJYjN1Z3lLRjhnMitsa2RrcGpPL3lacVZCdGxmQm03eTYy?=
 =?utf-8?B?WGx1cHh0WHQvR09lT2xxVE5wUjNCYVZhblNPamliU2xvVHEwQW8vQW1jZTlT?=
 =?utf-8?B?Y0phbXFPNFNqcXEvWHE0R0RHTFlxd1ZOQ0Z2aG1PQWdZSkdaT3dtdEFYa1B1?=
 =?utf-8?B?My9EL0VyZ3Y3NVJhTnNQQTBDc3ZicTRCeEYxeDduZ2dNc3luUm5jVm00U1pN?=
 =?utf-8?B?eFhhWmJaNWh4QzZlYjFneGVnY2pCVVg4MmRMNlNvb1p1N0ZqZ0NuZUl4NHYv?=
 =?utf-8?B?c256VWNTWCt0ZUVEN0hYWGZ2TVJkaWs0aWVzcERnRGI4L3hhcGo3MW5ZTFd2?=
 =?utf-8?B?cWhlbVJRbHQ2RGRjMnBUOFBKanhOQnQ1a3pxQU5rMHdnME5XdXhBYzlKdkxs?=
 =?utf-8?B?YTcrUERLdWR4VUZPYkxqVEMxZmE4RFJvenpnVmF2Sm5LU0NOY0ZzYVdOanRQ?=
 =?utf-8?B?MDNQeDRNQ2EzVkpEYUZYRGxoeU9TdFpnQUxDMStUZjJlSVZOWTM5MlBxUTNa?=
 =?utf-8?B?dCtuQW1PdWFKS1REMEdNUnRxQU51NjVQU01ubFd2Y1BzeVBmTk13eGo0eUVI?=
 =?utf-8?B?NTZ5MVhCWE1paFhDaWFTbTdZbEhMQTlFcGtCMEkxc1ZhTGhHMkcxU1ZXNFlH?=
 =?utf-8?B?N3FpS3JnNW9XR2dxdVZKa0FJNFRGcmI4Qm9LVGdkTzZIdlNtWXBNb3p1dWVI?=
 =?utf-8?B?c1MyRlVXYnZNK2hWWkdzaC9rcCtHYTRmWW1kZHpkdnh6MCt2Y0VQSXZ4a01Z?=
 =?utf-8?B?d2xhNmlFdUpqV2lOTlF1NmhtdktjcVJnZWR5S0lhZ0orbmo3NmhDMWY4YStN?=
 =?utf-8?B?SkV5dGZQSWhZMEZ3bUJqUDdieUdSaW5IK3U0SVB0Ymh1aTFDVUZXS3RhOWFh?=
 =?utf-8?B?Rkx2NTlFeXJhNExwaDM3R2V3OFBpbGJWaThyY3dRWnhXS3plQUs2b2pyRTFR?=
 =?utf-8?B?SUZhall1Zjh0dU1EdkNudUY0cTQwT3dqNHVuRHlITHRRNVdQNHNqVXgrMVR2?=
 =?utf-8?B?Y0hEcGFxQVU3bTFWcmFNYmZ5VVBhQUtVUzFGVzYyL0lHeHZHK2U5TFN0Y2Qr?=
 =?utf-8?B?VElxREwvdDNFdFE1S0tuL3JVWEFtMmxqUDFpVWFTbEcyMGhCOThSQVJKTUoz?=
 =?utf-8?B?dmZkTHE3c2Rza1JZU3hhZlgydmp5b2kzK2tEdlExdEM1cTArS3lCRXJZYk81?=
 =?utf-8?Q?rUpgODqy/u1oM01fKttLaBtzh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c61438-dea4-4da5-ca41-08da9732c3b6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 15:55:51.4979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOZled5Zs7wcBoSBXqGfbyo7MoRUoNRFouw16foGIg2X4O8tx16paoZkKN27EVxskhC+Brsps7YZk9gbLBaiNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7351
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 9/14/22 15:48, Dave Jiang wrote:
> Duplicate log functions from ndctl/monitor to use for stdout and file
> logging.
> 
> Signed-off-by: Dave Jiang <dave.jiang@gmail.com>
> ---
>  cxl/monitor.c |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/cxl/monitor.c b/cxl/monitor.c
> index 2ab2e249f575..e030542a3fe8 100644
> --- a/cxl/monitor.c
> +++ b/cxl/monitor.c
> @@ -39,6 +39,32 @@ static struct monitor {
>  	bool human;
>  } monitor;
>  
> +static void log_standard(struct log_ctx *ctx, int priority, const char *file,
> +		int line, const char *fn, const char *format, va_list args)
> +{
> +	if (priority == 6)
> +		vfprintf(stdout, format, args);
> +	else
> +		vfprintf(stderr, format, args);
> +}
> +
> +static void log_file(struct log_ctx *ctx, int priority, const char *file,
> +		int line, const char *fn, const char *format, va_list args)
> +{
> +	FILE *f = monitor.log_file;
> +
> +	if (priority != LOG_NOTICE) {
> +		struct timespec ts;
> +
> +		clock_gettime(CLOCK_REALTIME, &ts);
> +		fprintf(f, "[%10ld.%09ld] [%d] ", ts.tv_sec, ts.tv_nsec, getpid());
> +		vfprintf(f, format, args);
> +	} else
> +		vfprintf(f, format, args);

The vfprintf() is always done here, you could just move it outside the if/else block.

-Nathan

> +
> +	fflush(f);
> +}
> +
>  static int monitor_event(struct cxl_ctx *ctx)
>  {
>  	int fd, epollfd, rc = 0, timeout = -1;
> 
> 
