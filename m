Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590F41CFA9
	for <linux-cxl@vger.kernel.org>; Fri, 26 Apr 2024 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714158629; cv=fail; b=d6r0Rcwl/L1LPsng96OO9DKfiq87d6v7C9S8aAeSd8ZnyYvsSudvawHrjlQFzyNDm+Z87PWStc6jD6zOMsv+B6i6gRkfZAr3wikGdevnYTcDMeu/WeW0BbEr5A8RK9alVoWG68oLpvPSodIQba81pWptgkqjIsolb6h1RMUHgZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714158629; c=relaxed/simple;
	bh=P3JrgSOaHxAYAMdUmvo105pOq7VDHwfMYRWRnCLLiUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I4VnUZNV5wQY4bPCklyKVk26rFx3Xse7L+VTXcLM1hv6nttJ5dD3ifbkKI4MAky74snW0H1ZwnxDENjwxrssV2AKOIpoSNoMWulE2EIcdCpwcLaHtxevhhAYdfDrUATZkcX3FVxxRuL0BzXT4+AoK3UUPS+LqP2SH97umd1AHE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cmlhCUV2; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cmlhCUV2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvbhvY2MsGvqhYgRgROuE07f3gluKfH1hhZFfSzKL6WPOhHcKfJseOJvNoxPz1UEtzqAY2TGHUTWAzLcw1RXXSqkIMTeYfnLXeDkZPmqzI0NITF3b+mRU/7e/+eWAAvO1ZihXzBd7CB7zaBXwKbZUZyFQJC+EsNBzVELWwec7CNEi2m74bCmulI3Ne+Ds2V3wDSHpsTVhr4Fnczm/1vw7HmczUO9BNtgug9E2LA1YxYGsVfJ1T0c2kZmwn11pq013E9aSzP9wv2kM9/+dlVsFwVGzwbl6/pwj6WwDtWLKtQr6zsQ2iEzcHW3Woaa2tcQXmSI/jM58MHjrQmm0No/fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuPQczSeUwVhb59akiW9JgZhXDl1ZM5ck2043CXAuWs=;
 b=cpSOg3MQlCuLt22C8Us7nd1cZfKzNwOlFiGoZNDBOuPW3um+iDlZfWr957LzOTZCIvQ0y5td68VNj9XQRbLwIdAv4eB0HHd3u6FHPtgdTk+FU1Cziof9jOycwEeB2dQLN/8bzGyl3+ueAy95vkWw843kOlQsfUdrPmR5uOoVi7wiPHSESE3JTEZEpVp/y8oc4+a3itwJe4j5JsCtUEBUoZ6bgT1gTIzjiSGIUtpcQlQh/9eW/SmXdEQuUkk69jDZ3v0kblCFHSgV+5qmfSrfJpjGYRHU59Wm12/Kp2+2x4VxHeKaFjeo4FGGqbm0SDND516Meof95qjrnZ/u7buneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuPQczSeUwVhb59akiW9JgZhXDl1ZM5ck2043CXAuWs=;
 b=cmlhCUV2tlkJPM7X0HjhBUZxmOGoSmU8O3A4hfmtZfX6Be2tTA7OzqkxqNm2YJfuwLHN5w7KauKyy1TuH+aTal88FRvfWs3tepJ3zuza0wNPWutX/tSxif+wl27r+55nI410Pn0BDIAXneSdHWRa1DXc9yBypA44yWTJI05ONDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS0PR12MB8814.namprd12.prod.outlook.com (2603:10b6:8:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 19:10:23 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 19:10:23 +0000
Date: Fri, 26 Apr 2024 21:10:17 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: Re: [PATCH v7 1/5] cxl: Remove checking of iter in
 cxl_endpoint_get_perf_coordinates()
Message-ID: <Ziv8GfSMSbvlBB0h@rric.localdomain>
References: <20240403154844.3403859-1-dave.jiang@intel.com>
 <20240403154844.3403859-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403154844.3403859-2-dave.jiang@intel.com>
X-ClientProxiedBy: FR0P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::16) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS0PR12MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 34281283-fdf9-460d-17c2-08dc662485dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oPf8oldWzk/HZuXz6wa7HJlpoQ2+xIymmZgCJmLSfkG4dccEsK/1r932MGeC?=
 =?us-ascii?Q?CvE7RxW8q99xPEGvdezpUysPH9rO5ZJo9BN8fy/PvU8/hafSLdJiW1XAn1af?=
 =?us-ascii?Q?e1Pwk1savUkEmizbFC5B+1R/kjU7dYlMoLeKH5H3Ea4w7SedVd5For580ivK?=
 =?us-ascii?Q?xCVA4qx5nJFPoncagpBFYLxeMWIlec3P3pJtCD7j3EZq97PQtyMdjpMcQlDf?=
 =?us-ascii?Q?zJFfunZlBJTTSEHKMjiCD/3t5FoqcI/kxSXMUZzQRg9kl2zWUXxpBgckHxta?=
 =?us-ascii?Q?88OqfTX5JDUpjdrMDR7xj67ANkeBmDZy6DV2D7klKZK/9F4I9+lCk1bHchBk?=
 =?us-ascii?Q?5p2U1RctCTSHJ5k/PmIy+SmyOic04ALrbfthOoHCh3ui6T7LQqED5a76XvfB?=
 =?us-ascii?Q?c/GvBueRFjOhkqvQy4EL7iXE0sN+uGqFMFeBckRgrDFsBo58BcjFrWgEGITb?=
 =?us-ascii?Q?Q1FGPY4CQZLg3+78SbMUvk7/aRRPUCdCv3dx/VHuIExgXJuV7XtefPjw3Dnv?=
 =?us-ascii?Q?g0DSHbm9O7q8dwJFzh/dOMUNefT0Oqu9kxCr+NT05IbdimjSxwWpRZLOhlbt?=
 =?us-ascii?Q?uInWPNzEZpmNPJp6Z8veS51XISCceKGzXKmuM34qm1j0/e75iKxgQ7U2mS0z?=
 =?us-ascii?Q?fBNV7a1PeXjyMdrhWk45Wtd4G0YwLF6kDAyRhyJTVUpnMMI5GSEoAHWiEuld?=
 =?us-ascii?Q?N6OJzbyoiS3WSjymdZX4+yhM5a8qDTIM8iEVZXMV09rQwAlwHN22Mv8cadjz?=
 =?us-ascii?Q?OdLX8i/2MrLDAWkQMPCgSBPxpyQozgSKZ8lHhVPMzCYVdhrbtU3XgM6HQVbj?=
 =?us-ascii?Q?zOhzuvkRMWvSfFffhEmxfcMXqH0dmdZNEsFqAW2BGX4ntgoqD6fBA6HDNytM?=
 =?us-ascii?Q?BC8G4QcITiqYfbS0yEQGdI4eyvljjFskuR260IW8i7EuIjFXNBENVNoN5Jh/?=
 =?us-ascii?Q?T/Mnt4ywEDxL6Dp1IExOACWFzvCr+z4tAnj4Dxjs/IvKMSVU+EzkZwZDT9/l?=
 =?us-ascii?Q?BINHd0EKCfrm4WxHSy7Z9pb6LBCULtcLiU7+KKQrvHFuCqBf26yQ/xv9e9XV?=
 =?us-ascii?Q?AdyGyqghIAQjDZRSsQVL/PtPVsQOKWkJgzMsPa4twwy3ZEJMubvOl9hPYGwh?=
 =?us-ascii?Q?Yqf7b0UD6SnlJBLVPXKEbhnukmqhaKTPC+0HBBbZwWLA+EDvnjbbq736k1gR?=
 =?us-ascii?Q?OSU11bP0UjjnI1lfCco0zUBLV3Sx4tD8ANkEQPfligG9bvtSSkLM5HAcEV0s?=
 =?us-ascii?Q?rx2deoUex+tx8TJdsjmoMIWj0mPaVGF8ENHgMPk2NA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DOFkQn54UO6q9lc6wvrK7cPpDRdIa/WOWU5eMaCGswoFrNLMrgUdHf4yBzHm?=
 =?us-ascii?Q?NE+N5ZqEIujIx1weuaeKbjPOXu1IiehMcCB/ltoP8Ud+jhO16StKHDQD4sZn?=
 =?us-ascii?Q?ayitonK6y0oDq66lVUAaD7dJIV24zsejwxZSsWUdOMxLh3+moMBmOl3B5a1J?=
 =?us-ascii?Q?W9RUB0Xn4R/ovtv7hIr3KT8+zSs5JZwxiariund6e4/CgvNYJ9JqcGYIjMlF?=
 =?us-ascii?Q?gn+xX+8qUGE5zzWCQuL/fia9o0KwdSHAzI5U7oXd8R6C/st5r+hqCspkpR8I?=
 =?us-ascii?Q?8kzlP7TDTrQbYG7mnqIAESm7jhT1gwaK/Nuzi6y385PhyH2n475OF4OiWRqW?=
 =?us-ascii?Q?2h+iK8Nhe4Gl+B5Jqhk6mhz8pOIjvJujJoaGsNNj7O7Jw6KInrtSU4UCk80T?=
 =?us-ascii?Q?AN4viRlAc0sV3iEieirgdo9eN77oLqAI3Mc8TzSMO1EMMk9CFGrbVJmTevx9?=
 =?us-ascii?Q?3BpZyxmksYlOmF7lXRJiBCCdkmb/U26UGL2XoWMFbh0BPY1rYZitNkBQGWGE?=
 =?us-ascii?Q?gAvnlBERjaC8r9ShyqKHz6PrkMtfR4l0oIO9u0jAZVO2alTUCQfUsyVlQfYm?=
 =?us-ascii?Q?YpGTBlw/n1cuQ8z/lfYhK0rrazDTIiTD+J2Aw9/wUFBqhIT5s6TvdPWMOBni?=
 =?us-ascii?Q?O9G20KhRl4I/hqeEUatbyhvPAffsn2CFC9mYfbJdxUKLaeCzZEi3NBOoouY6?=
 =?us-ascii?Q?rFn70YBxNhLPZV68sVF2zlzRAgd1C7bCGyzzrRTpv9L97HyJisXmOI/JggKx?=
 =?us-ascii?Q?Mn3olhTLP4YcqhG6DDn6S6vAPFaYDhC3GuAjLg7DbgCsBj+GdWVfeI+AG8Dr?=
 =?us-ascii?Q?pkbS1rW39fA9sHyPlGhuZsG0XCWPYIIo6TkO7R1SU2e/DFFUqpX29obmFUqI?=
 =?us-ascii?Q?AC7ZANX4NVGSpUTqPZwRGL6sxxf3KxxTHvAedCnpiGd8uyy2Y2YLjiAs6A1w?=
 =?us-ascii?Q?nUCp0tK/b9b7vundOjn1l+Ptf2Wr1i86r1Adhn0xW0U4mexCAKrzg/ZrTCgB?=
 =?us-ascii?Q?hfpG8BOvNhnHRQS+S7hB5bQ+ulbM3gVx4QkXG2T1OlPnBEiEiKdS7/O7dpTy?=
 =?us-ascii?Q?PCQbAYktRTfM5El0Ns8YWY+q4zbNJeqkavgnrmaPBNOEaMk5I9lV9jRGfU87?=
 =?us-ascii?Q?ZOniHB0thshRi5HimleGgsJEk+QZTLZas6IK9IfvPUUWHXht8wv0URd9jT+M?=
 =?us-ascii?Q?rX1/dpBU2jkwCyk8ac0nbfYGcQRHEXImPXWVZSz7AQV3KMkAT2QihESGWNdq?=
 =?us-ascii?Q?JhF3cnnj+vmyWahfauwJXDt2nNP+BcPCEfLTAQ91SWGhpfEywBDv0Z/Fa6Tk?=
 =?us-ascii?Q?1xEHNoOVfXEf3bAPheE6j0w7Cnwui2qvCFj9vcZI0EaXWfGHyyBkDHPOHKI+?=
 =?us-ascii?Q?uf2MeomePOrjgnGoXAyWzX+cT+WTBdYbVxBZSsgBbzXoiGKM0j9dW3f8PsIz?=
 =?us-ascii?Q?VvXhO42N1S4rRbe9Yz9wdp/Ty7Jb+RyEy/0Q81pqWTv2tlqdSCkEmgP60GeY?=
 =?us-ascii?Q?j1zSKbBGuhJcLxTgyK9pNvktxMEVYSDwc1cNiaH/m6J+UBn12VNW8lhI9Zyd?=
 =?us-ascii?Q?dCHk4jiMRZuwoBhqnq8YsTcZe+yMx7sFoh9hpdHj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34281283-fdf9-460d-17c2-08dc662485dd
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 19:10:23.2447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYFwQFz/uj4AD5UMt9xiiaVQiE51y0QzcN7LDpIfA5FJGmeQ9bly6BVOd4DWiETOFvCmhQ2Jjpr2eDyEs4r74Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8814

On 03.04.24 08:47:12, Dave Jiang wrote:
> The while() loop in cxl_endpoint_get_perf_coordinates() checks to see if
> 'iter' is valid as part of the condition breaking out of the loop.
> is_cxl_root() will stop the loop before the next iteration could go NULL.
> Remove the iter check.
> 
> The presence of the iter or removing the iter does not impact the behavior
> of the code. This is a code clean up and not a bug fix.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 2b0cab556072..6cbde50a742b 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2197,7 +2197,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  	 * port each iteration. If the parent is cxl root then there is
>  	 * nothing to gather.
>  	 */
> -	while (iter && !is_cxl_root(to_cxl_port(iter->dev.parent))) {
> +	while (!is_cxl_root(to_cxl_port(iter->dev.parent))) {

I am seeing the following mainline after [1]:

 [   39.815379] cxl_acpi ACPI0017:00: not a cxl_port device
 [   39.827123] WARNING: CPU: 46 PID: 1754 at drivers/cxl/core/port.c:592 to_cxl_port+0x56/0x70 [cxl_core]

... plus some related subsequent NULL pointer dereference:

 [   40.718708] BUG: kernel NULL pointer dereference, address: 00000000000002d8

This changes looks related. I am going to dig deeper here but just a
headsup in advance.

Note this is tested on an RCH topology.

Thanks,

-Robert

[1] commit 586b5dfb51b9 ("Merge tag 'cxl-fixes-6.9-rc4' of
    git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl"):

>  		cxl_coordinates_combine(&c, &c, &dport->sw_coord);
>  		c.write_latency += dport->link_latency;
>  		c.read_latency += dport->link_latency;
> -- 
> 2.44.0
> 
