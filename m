Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793858417;
	b=5HGu+4ZiOY8i+CBHW+ELC2ZrV0MFt7nztFE2rvgv2mWc2V4AIFC5Q9QG+vIZchgqGvD0
	 2njH7gvn0zaHubiHoSKjcHasvcjwonFdUj0k9l0IQVt8uTe4/4wJ+GGxGq7t552T9JG9v
	 eYBOuwatXeFSBClEEPZ0eszd5Us/VYhfkqqsxjKMtEPd/5JKu3J5vvu5EvRhIhUx6tEJi
	 Lkr+f0Ybf6CJHGwRwqOxSh5DaN5ghLXRS+NRkUhsH9FASQ9SkWG1rdhAAzqoDVnycH7fQ
	 wXe6AOsltYb4q4ShzEVxxpIBHGQbOO439hKNp552Vw8pKHDhsKNLe4l2iQNJDcgIyvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793858417;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=zVLx+MB5smprl7bq4gLGVgspXDhpIWFZijKZcCcmrlU=;
	b=fCS2MggzYY/1YRkztrL/xKzkFQBUDhxXOcw9EVWjvqqeYq097QdGJXP9Un3m5WBE1mVY
	 4DR+7CY5zDegf2DZTZhyYTMtL52mWzcBTOgC8Idd7GaZhoK6EsyhbZivIQ078TJ/RhtVy
	 F6uyfcwBwhCtJaRPrgPsu0V2K3wXrdbfFsYDwrBOGM/XCUn2kad++GKDFhf9tcyXWzD41
	 rkI5Z7zi24Qq4akv3FYH5slhgO7lVfEB5tDU+sTQEHMdx8ftVznVRwQ8CIMvJokUIsDUH
	 VZQ/pMrECYQsrE09lQb8c2XlBPwgC64g38WvH7C58suAh3ji37xCLQaEdqdQteIhUPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=n6zSQR8H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.18
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3C9606A329;
	Thu,  5 Nov 2026 06:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA3C9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=n6zSQR8H
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1M38o8Rcey78jpC2LgsS+T/VuBiemngb7SW8pu7bVzGSRIIYYB3NGlukOIqrvLinm875jbZtFfXWMZqTX/t2SzSfsLnh1FaaKwj8SLsnpjk9GDW23kRLB4Tfc5Eih/uFIOtw/XeAyQbadNG5G83RkQcXgd0joIUtAFAI2ogMn0TEZvGpQXtpA5JR52YdAsfm6jJpUieUXb7uuFOYbwscvaOWudX2pJmVfNF/lZVueLAnmcH99UCUnyPT3KvQupaoAJZKk3S0yUehCn+l4blWmwAVg+q8tRAUwsV46FYfyguTSyu5tH12v5qE1iW2lku4na/j5u0wLtMIznTEiEmqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVLx+MB5smprl7bq4gLGVgspXDhpIWFZijKZcCcmrlU=;
 b=LyeIw80bl38/G7vziwIXieeUhu4ou78JX6yMfJMiP+6cZzTy5g35w3O9nBaWMLv8PvkLEoSPwzDJmUY1YiC9EUZtwl7IpA6OQnEJc/WtgzsEUWQ84GPhqH/mjadvtr2SRO2Jt3BmBoKK1FnQZl4gMf5HQ3lC+czqY7F/Rd1evHWOlFnL7Fjn2oq5VjTualyw1x5W0SasiFWCd+8yfAyEcb5wRjy+28Zprlsdv/BAJaxosQgVQ2Ov4b+UNFSLg8ERmT/qAPK0s//yCopVX98agS27PedtddyJeXYOy3UWEG1k0EQX/D+umMooLrGe53GD0r38zNhgDXoE8C4p+LS9jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVLx+MB5smprl7bq4gLGVgspXDhpIWFZijKZcCcmrlU=;
 b=n6zSQR8H/Rk+mVOMeF+/zgxE5WzKcZUog4k4RzafQjThAq/4vf7rB7jAfHj6TRsnedFhXfcQYqhS7Nxgi1gpXyJkwuWE8aJtOhjdaH2t3ZwqPDiHq3qi4NPhB+2Q4QR+bhACehpE9HrXMyErc9RXNbVX2yD+SD5Xo/E8C7857mBH0Z3MASnvHE4JHI6SKtiAllUc9VTBHHIbWzPEHVSoxwproA4wkgs6y+3WxjKeJm1ENIdtdkWNMyw5PM5DJMHColGFrWWYxyhD/pSC3wilKnZplBpqU/xi123Pp/DmI1Ya9/WGdhsZtKd6ojQ45kBbgEpiPKCruxkC98wafN0Yqg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 06:00:12 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 06:00:11 +0000
Date: Thu, 5 Nov 2026 14:00:07 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Jongwon Lee <ai@linux.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] cxl/edac: Read cached DRAM event records under
 the xarray lock
Message-ID: <auwbPzKVrSod_yXQ@MWDK4CY14F>
References: <20261102123233.74598-1-ai@linux.com>
 <20261102123233.74598-2-ai@linux.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102123233.74598-2-ai@linux.com>
X-ClientProxiedBy: TP0P295CA0024.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:5::6)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1d0f0f-a574-4e15-0ad8-08df3b020da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|18002099003|22082099003|261102123227099003|261021121427099003|11063799006|56012099006|261009223027099003|261026140227099003|261022105027099003|4143699003|261028144727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	rbSzAM0Y+uyLzJ9BxRAdlQDKmPFBnvb9oevmwWyg8ij59JwDHzP9scE7EfztGyNPrh6mzlcwhBSkxWShHwkQypdAeq/BHUS3irbp32mov5kChTRtCINQ5vMV6RnYq8AKMkF3bxIiroOCrxJp4n7PUNRSdTyPwm3ejyvRtFjJiDPHzISZoLsubLnWQkx19Vv5CewBy5fahGLTwbk16EpEcKj3noQWCzFrDP9+pGm3ZBUz6L3iFgzDz1ADX6aJBbc7xwHVr+KSR6gFj2FGLQ7QvDfo8UVAM2GUHYJRZCvM9A/sSC1OirIpOI0Lr8lwUY+F4r0/MbG7nssKld4a+HZ+5J5nbJoTcBbSARCF8lumiQXlSOAbJiyQB7u3jj258f9APsoA9UPRTRKu+G86dwWh5tbKfKn4kRs17QbJzi6H0Hd2RW1n2+Aq2+qsaK6mA+qnvaXubTZ0gwb4c51T1m0gfZCHtPkUj+Vi/eHWPZkiKGQ4VBUA1YFTeYGcyiAS7Vvo9znvtp+R9r5u7FSzanJVjOvtjlf3jMBghKgUPmObzp/gJu7d4riPAY/BQlGTBw6SAeyuvPdp9hdgp+ffwl6mf0B/zlJYawZVWQz0KLnS9EsWQGgBWakFAaWbybkmVD9YrQ+pUGXatjJjUWMurNHqlgg4Pr/DNrd0P3rp8S+gcao=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(18002099003)(22082099003)(261102123227099003)(261021121427099003)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261022105027099003)(4143699003)(261028144727099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RegmJ8oXvfx9kfYHIfOq+d6Lkp2fMjwoOU8+S78CqeCXwXZW9L7Gaxy8HPI0?=
 =?us-ascii?Q?yKvLU+afkpPGkzuteNtcIop4hGfKzOJ6k8AZDGyTrkOf0aJ29NbVG00siYjk?=
 =?us-ascii?Q?6POygEQ1ycei+b6om0pEZRR5fSBAiD79AD01UpT1ntMqIdgOdMEyjH3wXfNO?=
 =?us-ascii?Q?UeWsI51xlF2JaO2N11CD0mjTPRIJMCC3/nb8cJrl9NN0bqzoj3k6AgYs3wUJ?=
 =?us-ascii?Q?tmi1776NVzhq4i5uo9FYuCHulgwsnjl4jbj4OszkERv8FksOj/Mirp7OYDyr?=
 =?us-ascii?Q?4vU5EvAmAR1oMjy2OVMlNrWnT+46yOeyhAi8afo/hd+D/xLACiWrlzqH1FfZ?=
 =?us-ascii?Q?kg4Zcxxw9PgdsXn+M3FXec100TF0W47i2Plo8pwr+a6OmiG/qltSjDSnP5Sn?=
 =?us-ascii?Q?WTKdesTXvJWXZBrbMRCeFJ2Jhx4OhfnvTOt1caTpME0kZq/PKczrOuKaP1JU?=
 =?us-ascii?Q?iDDBHLOZJ3OdnXke1yGDcKJbNKxPX9/tAV0JqcB6QCYaATdhe9Dkyiyd4YoO?=
 =?us-ascii?Q?JB2OiDhOKZrXU71KJ1fc40EtUQIpuH4Bg/lKTwn8KEwpbhQs+cETY12JjH/K?=
 =?us-ascii?Q?6Eiv0nTNESBvq1fiQOaWwuk+g2mn71m2Vcg1H3xsSn4X22+KWh7pafsh6EUZ?=
 =?us-ascii?Q?pTwRK9rJ7H1f7b37nRf/CL7cdeTJqgwDnxBJFcA1fWk5j9eZJavFrYChlwdr?=
 =?us-ascii?Q?1Fa7NALzqIUXPW4OKipgV+PtFLmlYVtyz5VFHDuwaSrpNtEPa0865I6lsFOG?=
 =?us-ascii?Q?oEORL8UlXwrHnGY5Xshm2JgiQvS0HdXqWzE59YApqzpo45QKHKTm07J9mRT1?=
 =?us-ascii?Q?xEBA4qgdszu5fgpZR3u7nllnLLFCEWyn1P22lML0TQQ7u8al+RjkZyNteh77?=
 =?us-ascii?Q?RQ/6MBGClpWIOcM0c67wpJuU6/EZPeyGEesp17/+4/sfa9+EzRhA8dxmsD51?=
 =?us-ascii?Q?HjAD81A2oUWxJgVHjURew3qyiFGK48WRUcRersgcFoqvX+xdFnZL6BhBs2da?=
 =?us-ascii?Q?k/do+D47RHqdOrU4okWP35sPht1UB0i9+3nJ5NsEcX6eDwjry0XrBIG6AiJV?=
 =?us-ascii?Q?pw5oHPxGM63J2A9cwZw+kPKlyzZkCHrTBobgbYkxDM4YYQtY22nvGQecWUDP?=
 =?us-ascii?Q?zREpYlOTEydTBU37ahQvGv9bx+t2J9MuheUb4NTAAYqnaHK3bZdaeQCVGCkh?=
 =?us-ascii?Q?/efLgea3edfjrED1THY/KqhnsY71Rs8a0fRh/kMek1oR5B/GesJqrxzzfMgS?=
 =?us-ascii?Q?K3eGcbnFwpLwysMp2IugFf7e/+L5eHqDDwL/1/SwMh3wSTM+zaRRD5dWqr8F?=
 =?us-ascii?Q?ad5DapY/trGnIRaTVX/OyQL8dRFBpD3e3MJxRqT2zOK33LMECU7b+hVNoc83?=
 =?us-ascii?Q?tMO0FSETKxnkV5vW05XQoDw+O46IhtK8mrY22mXb/Nq/pR7WJTBxM5YUF5Sz?=
 =?us-ascii?Q?jdniNTSffhJoLI4kS3wCZ4KR4z8YG/aQSFwZ4f22tI0F+oHSv7p7QcCboGRr?=
 =?us-ascii?Q?g3EpmIIrprHv27pFz9BGbIuugNbwZY81FQBY9p1unWWxoB5dm2qFqwGgBuxs?=
 =?us-ascii?Q?xBl6jTmPFOSlrpEEuNlGTRY8Pd/JZnw1Fow2SJ1izwd9vQk5bOEKpDP38/pb?=
 =?us-ascii?Q?qFq/hh4pisRwRFIYK+Dtgo3HzkJI1hPP8pFUsgyNwGqeHXpgUD3iK0flvjad?=
 =?us-ascii?Q?MssM5CU+A5W6LEI9WczLWCZZzDMoTWSD4SbCBOOUS/dZDhCX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1d0f0f-a574-4e15-0ad8-08df3b020da4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 06:00:11.8585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdWN1IZa1/wr6m4X3dFBvbkhhH5yDICqBAhgshTKuZh/1HqU/kA+dfA6QqI2LaGpewDRA36LCzk6hl3OS8w69A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452

On Mon, Nov 02, 2026 at 09:32:34PM +0800, Jongwon Lee wrote:
> The event path caches DRAM event records in an xarray and frees a record
> when xa_store() replaces it, when it expires and when the cache
> overflows. It runs with device_lock() and cxl_rwsem held for read.
> 
> The repair path looks records up with cxl_find_rec_dram() while holding
> only cxl_rwsem for read, so the two paths can run at the same time.
> cxl_find_rec_dram() reads the record after xa_load() returns, and
> cxl_mem_perform_sparing() reads validity_flags from the returned record
> again later. Both reads can hit a record the event path has just freed.
> 
> Move the lookup into __cxl_find_rec_dram(), called with the xarray lock
> held, and make cxl_find_rec_dram() return whether a record matched and
> copy the matching record into a buffer the caller passes in. The PPR
> path only needs the match and passes NULL. No caller keeps a pointer to
> the record after the lock is dropped. The event path frees a record
> only after xa_store() or xa_erase() has removed it from the xarray, and
> both take the same lock.
> 
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Fixes: 588ca944c277 ("cxl/edac: Add CXL memory device memory sparing control feature")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-192042@kernel.org
> Signed-off-by: Jongwon Lee <ai@linux.com>
> ---
>  drivers/cxl/core/edac.c | 72 ++++++++++++++++++++++++++++-------------
>  1 file changed, 49 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 34b81e8dfb..c5c8dda20e 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -938,18 +938,17 @@ cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
>  	return NULL;
>  }
>  
> +/* Caller holds the xarray lock. The record may be freed once it is dropped. */
>  static struct cxl_event_dram *
> -cxl_find_rec_dram(struct cxl_memdev *cxlmd,
> -		  struct cxl_mem_repair_attrbs *attrbs)
> +__cxl_find_rec_dram(struct xarray *rec_xarray,
> +		    struct cxl_mem_repair_attrbs *attrbs)
>  {
> -	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
>  	struct cxl_event_dram *rec;
>  	u16 validity_flags;
>  
> -	if (!array_rec)
> -		return NULL;
> +	lockdep_assert_held(&rec_xarray->xa_lock);
>  
> -	rec = xa_load(&array_rec->rec_dram, attrbs->dpa);
> +	rec = xa_load(rec_xarray, attrbs->dpa);
>  	if (!rec)
>  		return NULL;
>  
> @@ -1029,6 +1028,32 @@ cxl_find_rec_dram(struct cxl_memdev *cxlmd,
>  	return NULL;
>  }
>  
> +/*
> + * cxl_store_rec_dram() replaces and frees records while the repair path only
> + * holds cxl_rwsem for read, so look the record up and read it under the
> + * xarray lock, and hand back a copy of the record.
> + */
> +static bool cxl_find_rec_dram(struct cxl_memdev *cxlmd,
> +			      struct cxl_mem_repair_attrbs *attrbs,
> +			      struct cxl_event_dram *out)
> +{
> +	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
> +	struct cxl_event_dram *rec;
> +	bool found;
> +
> +	if (!array_rec)
> +		return false;
> +
> +	xa_lock(&array_rec->rec_dram);
> +	rec = __cxl_find_rec_dram(&array_rec->rec_dram, attrbs);
> +	found = rec;
> +	if (rec && out)
> +		*out = *rec;
> +	xa_unlock(&array_rec->rec_dram);
> +
> +	return found;
> +}
> +
>  #define CXL_MAX_STORAGE_DAYS 10
>  #define CXL_MAX_STORAGE_TIME_SECS (CXL_MAX_STORAGE_DAYS * 24 * 60 * 60)
>  
> @@ -1298,9 +1323,9 @@ cxl_mem_sparing_get_attrbs(struct cxl_mem_sparing_context *cxl_sparing_ctx)
>  	return 0;
>  }
>  
> -static struct cxl_event_dram *
> -cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
> -		     struct cxl_mem_sparing_context *ctx)
> +static bool cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
> +				 struct cxl_mem_sparing_context *ctx,
> +				 struct cxl_event_dram *rec)
>  {
>  	struct cxl_mem_repair_attrbs attrbs = { 0 };
>  
> @@ -1332,10 +1357,10 @@ cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
>  		attrbs.repair_type = CXL_RANK_SPARING;
>  		break;
>  	default:
> -		return NULL;
> +		return false;
>  	}
>  
> -	return cxl_find_rec_dram(cxlmd, &attrbs);
> +	return cxl_find_rec_dram(cxlmd, &attrbs, rec);
>  }
>  
>  static int
> @@ -1344,7 +1369,8 @@ cxl_mem_perform_sparing(struct device *dev,
>  {
>  	struct cxl_memdev *cxlmd = cxl_sparing_ctx->cxlmd;
>  	struct cxl_memdev_sparing_in_payload sparing_pi;
> -	struct cxl_event_dram *rec = NULL;
> +	struct cxl_event_dram rec;
> +	bool rec_found = false;
>  	u16 validity_flags = 0;
>  	int ret;
>  
> @@ -1362,11 +1388,14 @@ cxl_mem_perform_sparing(struct device *dev,
>  			return -EBUSY;
>  	} else {
>  		if (cxl_is_memdev_memory_online(cxlmd)) {
> -			rec = cxl_mem_get_rec_dram(cxlmd, cxl_sparing_ctx);
> -			if (!rec)
> +			rec_found = cxl_mem_get_rec_dram(cxlmd, cxl_sparing_ctx,
> +							 &rec);
> +			if (!rec_found)
>  				return -EINVAL;
>  
> -			if (!get_unaligned_le16(rec->media_hdr.validity_flags))
> +			validity_flags =
> +				get_unaligned_le16(rec.media_hdr.validity_flags);
> +			if (!validity_flags)
>  				return -EINVAL;
>  		}
>  	}
> @@ -1376,13 +1405,10 @@ cxl_mem_perform_sparing(struct device *dev,
>  	if (cxl_sparing_ctx->persist_mode)
>  		sparing_pi.flags |= CXL_SET_HARD_SPARING(1);
>  
> -	if (rec)
> -		validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
> -
>  	switch (cxl_sparing_ctx->repair_type) {
>  	case EDAC_REPAIR_CACHELINE_SPARING:
>  		sparing_pi.column = cpu_to_le16(cxl_sparing_ctx->column);
> -		if (!rec || (validity_flags & CXL_DER_VALID_SUB_CHANNEL)) {
> +		if (!rec_found || (validity_flags & CXL_DER_VALID_SUB_CHANNEL)) {
>  			sparing_pi.flags |= CXL_SET_SPARING_SUB_CHNL_VALID(1);
>  			sparing_pi.sub_channel = cxl_sparing_ctx->sub_channel;
>  		}
> @@ -1399,9 +1425,9 @@ cxl_mem_perform_sparing(struct device *dev,
>  		fallthrough;
>  	default:
>  		sparing_pi.channel = cxl_sparing_ctx->channel;
> -		if ((rec && (validity_flags & CXL_DER_VALID_NIBBLE)) ||
> -		    (!rec && (!cxl_sparing_ctx->nibble_mask ||
> -			     (cxl_sparing_ctx->nibble_mask & 0xFFFFFF)))) {
> +		if ((rec_found && (validity_flags & CXL_DER_VALID_NIBBLE)) ||
> +		    (!rec_found && (!cxl_sparing_ctx->nibble_mask ||
> +				    (cxl_sparing_ctx->nibble_mask & 0xFFFFFF)))) {
>  			sparing_pi.flags |= CXL_SET_SPARING_NIB_MASK_VALID(1);
>  			put_unaligned_le24(cxl_sparing_ctx->nibble_mask,
>  					   sparing_pi.nibble_mask);
> @@ -1814,7 +1840,7 @@ static int cxl_mem_perform_ppr(struct cxl_ppr_context *cxl_ppr_ctx)
>  			attrbs.repair_type = CXL_PPR;
>  			attrbs.dpa = cxl_ppr_ctx->dpa;
>  			attrbs.nibble_mask = cxl_ppr_ctx->nibble_mask;
> -			if (!cxl_find_rec_dram(cxlmd, &attrbs) &&
> +			if (!cxl_find_rec_dram(cxlmd, &attrbs, NULL) &&
>  			    !cxl_find_rec_gen_media(cxlmd, &attrbs))
>  				return -EINVAL;
>  		}
> -- 
> 2.55.0
>


Reviewed-by: Richard Cheng <icheng@nvidia.com> 
