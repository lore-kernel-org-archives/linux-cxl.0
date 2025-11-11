Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43D32F28FF;
	Tue, 11 Nov 2025 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762860502; cv=fail; b=uJB1eE2w12BifnOKInNLmAhm6OZij8kzumia+U/GKWHy/a8vURKVQDxfnSibu65LdZNHV6ZDkutUgKgJsjD5oINKQ9dm4dmeH8GHZq/FgroF4rtAo3pegrXAFWkIBBvywed/aR/ab6xQX61vCql0TUkl46tj/QGt+u9RPhepbvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762860502; c=relaxed/simple;
	bh=DTFfmsqE30rHg0pJnQuuD9ar5+EN8bZSBgd63/RAG1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dAbpyiiZ+JwTasM2sp6RlyGs9pe3NGHjhEUs4I55gmV2l1H8eMM8a5tvI9kMb8byIcuQqY84nE/BLYZCXFk8gWz76kouI9mNnO498tg54mo8L7z+8w5/2dvxCWsHsjOZvmmGxcWyEygSd0WwRNm4LlDojjQppHzzCTpGkNOeBbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1cytdQpS; arc=fail smtp.client-ip=40.93.194.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1cytdQpS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJ9+hyGUjX9AeKVE1HpYL+QdKCvkNDPGVDhAwlzix6E8CLhHB9cUbqteGz+UYmVVwAXPuHQaJxCIES+kxdul3ppj4M+M+tyPzRVA8L7bjQNMcilA4G8zNoIBBYVqDWMQHXAAe/0EQE+VnALRfbT04xcz6JVdVLae6b9lt2F50bfrGBSXijQslkt5RRn89s5anmN15wGUhLChyyvgyQ7G9YfG6geiV2pkCZA3DA+Hy3AN4xUsNTHXfaxT8/qD+5HauwHNPydgxq2mfRe4LqtSuGH3/EoIekt2ZBPX0HT3q2odtv7eolq5dUZRjodh0DxbYNLawAdD4pfdZnPiqEImDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAFXPbT1vABRQO0YX7o6mIU74CZ/FEvqKzHZufWIENw=;
 b=cQNU4Vn7r3gAL2Ncjz6eVM5ovOhT8zjFnjt3fudrJZGLdXYMhln3+4O1tWP7ezGaDq7aE7i3bt4nSH+oXd5SIZmYZS6RfCsyyaWgTtGCWpFIG0K22ghrHrToDFON/BjOfOSrr8jJ60APgWS2b6zdFR2NlUfYBkpcLACowFDbyu8aIGUkB8gLtDFRIin7BAGhx24a66bodYSby0Hl5/TDenq/c5QiAnaF9VVUUy7CAHr11NgRXfuSNBh/FKDFQZ2vTvpZR4Lun9IIAk5kFWo6zrTD2mtLXLIEj7ZjQE1GpScUtYXKPaXShvKDEU6Kp9ZcghieJnMrneQ9S9ARIVRZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAFXPbT1vABRQO0YX7o6mIU74CZ/FEvqKzHZufWIENw=;
 b=1cytdQpSGkstWDScpl5koNy5JAJ8Ua7YtKIQS6U3eHz58n8bHmQQCUsFSzbYrBpBGbJe2HBkTqi3JpwaArjcUakyXYBa5fSFLQUlV3aPULiaT5Ydf/7vL3yNAFnDtPa8SSNOmh8ZAO/+K2dwvnrQRnk8xb/REyCp8Epzyu9CsP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18)
 by SJ0PR12MB7476.namprd12.prod.outlook.com (2603:10b6:a03:48d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 11:28:14 +0000
Received: from MW6PR12MB8758.namprd12.prod.outlook.com
 ([fe80::621e:d58f:ba3:b52d]) by MW6PR12MB8758.namprd12.prod.outlook.com
 ([fe80::621e:d58f:ba3:b52d%3]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 11:28:14 +0000
Date: Tue, 11 Nov 2025 12:28:42 +0100
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 04/14] cxl/region: Add @hpa_range argument to function
 cxl_calc_interleave_pos()
Message-ID: <aRMd6raM_3VLA6lG@rric.localdomain>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-5-rrichter@amd.com>
 <aQltQuCZZ-eckUIQ@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQltQuCZZ-eckUIQ@aschofie-mobl2.lan>
X-ClientProxiedBy: FR4P281CA0330.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::8) To MW6PR12MB8758.namprd12.prod.outlook.com
 (2603:10b6:303:23d::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8758:EE_|SJ0PR12MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: f71f4f3b-0c2e-44f9-f2e7-08de2115671c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KDiJZ1GG4cd5mR4j7bYQ2KutVuUP02MTYrWq2NcbYedNOl0JlbXEGjxLK7WN?=
 =?us-ascii?Q?skO597XI/+bkTYTer8DJPq4cEyamsNxgksmdmDoCTGbtJ53Hk2zdjr7g0aWY?=
 =?us-ascii?Q?E+HqA2gFeMkwaEZxhnRsFkYqQfCwK6IO6BYvn34dgH6G/r+98G7xnXq5V7Ro?=
 =?us-ascii?Q?P03p9xr7gZd44ppjy65mdCqs5ipzsbkp06A1UK7tLcrwdZSd9wgUeVncVrU8?=
 =?us-ascii?Q?kjdC2UdFnbZ3gnVmx5ry6MYhbjzlRJUtbH1ssw+PcwZfGWc7dKvBK8smsDK9?=
 =?us-ascii?Q?Z3PMP1KjHoDH09omnzXWrWvHsieROSGf9hb2GYVaUsk5KHyqNwSZ1uBVpjAP?=
 =?us-ascii?Q?YcJqVJJhbZyPORgGw19NLrPk5Ke8XGzmY7CCddTrAgT4+xNNbIsCWLp1MYu8?=
 =?us-ascii?Q?baLROAQtZgkvjVvN8Cf4T67lrpN0be2LIIVIegT1rK/iApEC4RFGFH1KBCiC?=
 =?us-ascii?Q?Ud+KQ7+e5sUMGkM5TpRhQ7WvgjUUcP2e5CGhc6PO42b61I1g4armPAOg6TvQ?=
 =?us-ascii?Q?YA59qB5XejZBH1qCAdrxcl8lY7d+8v4xv2Shaoaq9oHX34iLrHkgj9getKpw?=
 =?us-ascii?Q?Hl2H/dzkA2WUUo5CDQtNmeoMRDsc84tZNmgUZ7AhyBxxwAM9vCGObkzG04Xi?=
 =?us-ascii?Q?QeRswoZQkx0O2KkHlthwDjbvT/s0yi8neWupWnXnrpN1COCNAJYyKywQQdwx?=
 =?us-ascii?Q?HY/QfLvx5RoV0A6BF6CeICqL+muHozVDm5RKnD6bf43IlsUBoKLUuGlLVDIt?=
 =?us-ascii?Q?33TvF1Kvx1TFy7KwNNuosB0IOEoapab3VET6SdUm5FEze1cXZf86ybiBviFF?=
 =?us-ascii?Q?ydcIRNKVUPpqxslESOIgimHwYTtbNHBo3IDabqWtDk7EQ9rmjTndfQaWTqFg?=
 =?us-ascii?Q?cO8EydxpUuNrcA4ZBLIPg7/1GGPKcrScvNdws+990nY+gnV9dZbPZ3rJX5lW?=
 =?us-ascii?Q?d5i/oiQSx73dxMURcm3qTesBtaSoJSmI+uJB8JDf9NEXHQr55PyaE6wMFCgp?=
 =?us-ascii?Q?F/zy8cp1kbtMh6KGdcjMy1gUJyEZlg/DZb8rtSSQ0faz3Ghn2yiNq2Atpg9+?=
 =?us-ascii?Q?OSwPA7EqBwA0ileK5m2PSrk6MOi2ONBn8JeWGz3uJYkrX0vRHvWhK1W/lXf2?=
 =?us-ascii?Q?rFGSB5yzvaNEsPlPG40j5BchOIDXFl0xt8nBB/4Is/ibN6aLvvoUphcfiTJB?=
 =?us-ascii?Q?p67ZXEYRjXuL7mT8v+LCLWznKQdC1Myz83yjan0LbfEwc2acMJ8xDM650AH0?=
 =?us-ascii?Q?gm3Z2LqFmj/tL4xe67YfuobMbmXiSCxgOZWXx7w7yrRuFqFbQpsiWxpU6/CN?=
 =?us-ascii?Q?DyU5dAawNPfum8QY7UguasgxlZp0XYYm9PiHum2Z7qwdRY3ASAOS9b3C+JZd?=
 =?us-ascii?Q?Q+PQ4unpDRjIUWR8FQHAkaaiVVtGWiarvgWtXBxQ5TuR9wAmt1ymF59ouGBa?=
 =?us-ascii?Q?c+cAAqvApgbwrS/Escnc/Mt3Z5utS5ck?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WmQ2HoUnYgrqAyHvKKS09kLPuBPZ25l4zX8MvGNuOGvIL0nIQh1lYcZpLvuK?=
 =?us-ascii?Q?G6/Cgi6iGOB7kE0SS9mudhfzH3lOd77TVWL2akGOjNomHV18fOgU/4Z/F2rS?=
 =?us-ascii?Q?QK19pZd8D4pcvukK3tnDvgd9TiRuVc1XlzQCAe+WEv1RwKsU+u3VkNjfBi/K?=
 =?us-ascii?Q?RmtlVHUYW+eltaJHPtq84zTwn9vdNBs6Mq2VPXAdzOOMtIjL7b4j9ltY203j?=
 =?us-ascii?Q?1gXXAxNpNSTR4kl4o34670x/mtW+hBhLGG2ZDSXahOOImvQAvMiOvNKMNl5g?=
 =?us-ascii?Q?EyQS7SyuOsyTUaM2V9SBmdE93+RU8KqFL89JDt/U0NRxytRj/vuC/9WXxcv3?=
 =?us-ascii?Q?xgoCEPiks88q6QgyhFoHok9VKUDGqKi5PBzow2HgcQEQa7rM6SowOPRLv0JR?=
 =?us-ascii?Q?nnrehjshyqX7SYfGgof/AasZZWYX9X7hv07ht+yhErCdYuku16cfc5TIZs1E?=
 =?us-ascii?Q?LysRHgXJkBrPQZ81BRnmuKQuD3BYrcCcMqM1ftojUnfARh5JlKcjfhb0tAyS?=
 =?us-ascii?Q?Suc8peLLf0fl6Lav943fwhaVFN6HP30m+/h0aiH8JF1rpKo/gJAlCI/IRLJJ?=
 =?us-ascii?Q?YnbhAFOaGEATcJBnTjNVBRrW7yeg5ijV3LTxkIxAu5fFwhTHkqUjktxg9OEY?=
 =?us-ascii?Q?iTMUayXhYfcwCNpOBBxO2+EWe+Z280ealQwaubjMdnt9xJGi0jGaVQDlRRqs?=
 =?us-ascii?Q?/jO2tXgmxo0HeHjsQdW8KD4Ub5CVGbS//B+c1NgwytiJKMbI150GEujGWYdi?=
 =?us-ascii?Q?AqstnWoT5aGdL+JCz+eo5IdRnaAOKrSKorPxucgg5uN8DGqScsU/YYvqdCS2?=
 =?us-ascii?Q?GFGQEBII6HwPRy5j2fK2H9mj7Xbb7BM+tv2jk+qQ4U683o6WI8+aWvIgiqin?=
 =?us-ascii?Q?FNyur4BZDmM0V46F/hqiG26u93hkq+kJj820tjnP1Z80Vl5HlE5U59N6b0SG?=
 =?us-ascii?Q?4rr3g/88gJ83dO02HKEDHQqO/dkGeYGJx4am6C/hXnrENp4slkU/xSa/P6MV?=
 =?us-ascii?Q?3CzEnCD2cV5Mk9lkOB9KDNLTZ9Fn+dqOR0NSL8e1RmD5eN7AvHu9CaBBdH0H?=
 =?us-ascii?Q?Hvb23ExQMdfbWWXNUpEEQeFO+1UjVjzRt3ExWMxVb7Ggi3gKVhKS071rXmCe?=
 =?us-ascii?Q?dHO6EfYI406Ut9Zz4EL9TqcoVPHrAD6uwiWlGhfrIj9zXE9ly13fHw4ZLHAe?=
 =?us-ascii?Q?gpgfz/eSpTHZypX/mE7NSh7CrYB8kfC30SJ89qcVbuC0j+k51KajW9vJBels?=
 =?us-ascii?Q?K4EkKVM3WN0jyTZbgIxDiCHqmF+kGHH0k0ZbSqci7LvrIz3gT4up32wNe7Zi?=
 =?us-ascii?Q?vgxvPYqh5Bal0FPzvAJ6v58HBERQaoAbvPbZtJXcpE/uxO7urkSMQ0asBI6h?=
 =?us-ascii?Q?YOV8eZ4WKy497TCItZfVuRxs1wUizSjOe1DkkyE60Y4FyCbrtcsgP2rAk9bt?=
 =?us-ascii?Q?3g7iDr2kF82pUAxwYLms0hBCrmYO6PSt7VXpDsJcOAq9wV8aBgf/mrttyTua?=
 =?us-ascii?Q?sLem7WqtIZP2FKQtpJGVgGc3WYGLP2PX1QDe3cbQWXvDzhZWonYnZfRv4nyx?=
 =?us-ascii?Q?b1GrKyxvZtVo+Sk95bVfZFaWEzkLMGfo3wtKGim/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71f4f3b-0c2e-44f9-f2e7-08de2115671c
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 11:28:14.2827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mD6wF6QwHjhaB8DG6ZHwfwwGcfjE43TcRW16pfFv9Kx4QpRjXR1MBt8wvoPGSBf7wGIJCjtrn82MN1QqQ2delA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7476

On 03.11.25 19:04:34, Alison Schofield wrote:
> On Mon, Nov 03, 2025 at 07:47:45PM +0100, Robert Richter wrote:
> > cxl_calc_interleave_pos() uses the endpoint decoder's HPA range to
> > determine its interleaving position. This requires the endpoint
> > decoders to be an SPA, which is not the case for systems that need
> > address translation.
> > 
> > Add a separate @hpa_range argument to function
> > cxl_calc_interleave_pos() to specify the address range. Now it is
> > possible to pass the SPA translated address range of an endpoint
> > decoder to function cxl_calc_interleave_pos().
> > 
> > Refactor only, no functional changes.
> > 
> > Patch is a prerequisite to implement address translation.
> > 
> > Reviewed-by: Gregory Price <gourry@gourry.net>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/region.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> snip
> 
> > @@ -2094,7 +2095,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >  		struct cxl_endpoint_decoder *cxled = p->targets[i];
> >  		int test_pos;
> >  
> > -		test_pos = cxl_calc_interleave_pos(cxled);
> > +		test_pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
> 
> This is accessing the new hpa_range that Patch 2/14 started storing in
> struct cxl_region. It stores it only for auto-regions and this is
> a user created region path.
> 
> So the fixup is actually in Patch 2 - but this is the why. It shows
> up as a bunch of dev_errs() from find_pos_and_ways() running unit
> tests that create regions.

See my response to patch 2. I have a fix that properly initializes the
hpa_range now.

Thanks,

-Robert

> 
> 
> >  		dev_dbg(&cxled->cxld.dev,
> >  			"Test cxl_calc_interleave_pos(): %s test_pos:%d cxled->pos:%d\n",
> >  			(test_pos == cxled->pos) ? "success" : "fail",
> > -- 
> > 2.47.3
> > 
