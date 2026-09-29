Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913603D9DD4
	for <linux-cxl@vger.kernel.org>; Tue, 29 Sep 2026 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676691; cv=fail; b=HuW1f+3a3rGCxuJ/JJAbVOy8QTGGjk6xyXfyQejrwQSqioW/JBCdVavAgusqk4v+5uzxsT/H7huzooLrHRWn++IkpNNfZqX/vgNs/X+TPSzgxNbgKGMCjWtDrjvTM+AyDrxuzvBD2UL/WoCKklBK1fVcK7egofyhbR2sED28kGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676691; c=relaxed/simple;
	bh=zZ3c02EwANU0i2FVuC+ew05YMJu+F1z8gonBVFoWojM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F4H7Wn7BKI3xWzEldGHmWlG/vZeOYBhjBpsSgm45aG8KKRVgSuJYr78A2R9qboea2NKsmfa3daOuh5S/sSfx7o5RKEUA61LNpebBKjZCMy5NQXy6C/kwTqP0WGfGbp/TmJukMAI2obPMjmbNFj13Bff4fdGtpHikvydzrRQ5I94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fOB2HKR4; arc=fail smtp.client-ip=40.107.209.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fOB2HKR4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1NRwEEseQTCnJAArMyzaWCXKNYhrxi3XjuikOabkrb7nqphNsnd5eoTc4WLfIy0hUv7x2qv+UQ3c2TSFFSoUtR4X9g8e4CTVTvPJlXMnpc+Pbzip/s+5KHCb8fWQPqe4ImRPQgVqDV02/TdEpv9KN1I6l+Hwo/vGE6qMHhMSuFQ6uHypYkSj4HwgfwLWQeqxYdn3bIkdVqXX+rEhL5x/RAlhW5PpA0MOx2Q+30oHxzQ2dGdpWF8N2I6qlAzAxHqvHXCiDec//3DeealdMMKKssRZF1MEwrvcymuynOmUQyRa9hiJW15nUOMfaUgJ5FU7Ylkxsi5ttX6voL9W9RcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsKG4oZP7OJgCZIHZuwAXYqjQHRxOFYnP8M449sFd4A=;
 b=CBRIoSEgaAZ2/5MSdXHRd8gAJxgq4b/MZZMPFNOML1i8IrNF5Zdup49xAw2iQ37+/qSFvypWQZYKwjkljy5cGyyHbTsYqCIfqA8XHigi9KnMi4qm6vQ7v3kMn4lojT81Yg12GmkmTmqsPNk7xgnKy6wJarbFPV0FbvPIfTpmSJcoPa2T0OX9qQ8AKksIbx5nkYhRuuLruycMOeJByc356IacPnbYz5IN3LEINcxueEhylSQNToM1oomR8JqebUld3gPmXx3+NDe1B7/0xdCRcgJ8RwujEaKy6Y5ARLWQt0qtfTQmk56NqAc+eA0xWT7VaO1BCnQcbT+OqXo6hRhMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsKG4oZP7OJgCZIHZuwAXYqjQHRxOFYnP8M449sFd4A=;
 b=fOB2HKR41rOP3G1EqfVLiWkoGnx2iCtXPi38jYAIY+a/nSHqBGQBH0Mkvl2jpOiDAaQLUomZ6jKC7mttODfVe7qMMNLPjaS1SpBsuZdbrMal0JwunyrWmr5vDRHUJ5wXMoFAQvo0EGO+42sQYU+75M1X3bARacsJOatmtqm7xsYkRMXoawxojqOjshermGwdHB5RFgXP4CJ4YN0thZv50MyxEK1TnlplX6cnkWWR1PCUSUz9qftFojuHu8/eEq1XlCp2BRNlkGmnclTeh4v5jyTrYvkmPFoMB8uLK3Mv+pP0uchzzkoCr/V7vti2I/pngrYdd73s4ZUt903IKs0vZA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS2PR12MB9752.namprd12.prod.outlook.com (2603:10b6:8:270::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 10:11:07 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0451.014; Tue, 29 Sep 2026
 10:11:06 +0000
Date: Tue, 29 Sep 2026 18:11:01 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/3] tools/testing/cxl: Preserve DPA skip across mock
 decoder reset
Message-ID: <aruNqCJcxakvq3TM@MWDK4CY14F>
References: <cover.1790641236.git.alison.schofield@intel.com>
 <51807396d62a65dc457706b454102cedb6446bbb.1790641236.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51807396d62a65dc457706b454102cedb6446bbb.1790641236.git.alison.schofield@intel.com>
X-ClientProxiedBy: TP0P295CA0049.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::20) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS2PR12MB9752:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e12238e-f913-409a-4278-08df1e11f99d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|11063799006|4143699003|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OhWr9RjD9IRtEDLqCabWbG4ZP/Qm2EMo4YHHa1nsLnHeIYLrVEkKcR1nh4kP0NLT4ow03UgMlgdodTv634CjUJ1c3rc+O2GhLEp7rBUwIR3DsF/hfi8QSvrukkPhDn+DOm7aqCbpVUN0WObB/sz1iIHuzcP0sk7gu40YPt37BgjjO8wMnaPFi6mYwOrvs0NLXbtBDHJLeTn+E7KrUGtcLP3xJrBvkrwZQRm0ZPqiLIOgbiffu3ROGrYY2vEAY3G/2qj0OWhIR4ItOOKCviCU2gbt+55zY945OqgBUn9ZV50xOCWSmnbj+VAuqi+hP/MTyvASEcTynZIlGGzz5vjLccPeHWBzNHeWcshanPi+KSVMsrLTKvI+GAZNnd672L3HWlCY0umgfRxRsCMyZCWMa4JSA1JP+hAkfGMVZKI7lRtTIh8d4D6C2wuxpo2h43zcUj9M4s/pOYdul6E9sENBLef6bJ0I4mbNAdgcRRYoWe0toRLiYD3YJcqeJnKL5ZwFCgQ9WvEm27cIwlbRFmpwdGJO/8YUExqyva+p9eJ7SuK9Uq1Fgfr/PrKl66QwD2AqgwfZOHg4PgqiJ+xRiJY+uayKAG8JcFTSTrXQPeG7FbmMVh+S9UriDJYIGV32OJBTh2WW2uUJBRNic0ikOkG10oFsHWjm4kuN6YRCyn0TbOM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(4143699003)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ogm8NYK7zy75GnHHQKdzXnRapjMdwpbXw0keIE8zgXrUENxQ0biJJavEDU8w?=
 =?us-ascii?Q?xSWWcYySscKtQVP2V1oyVJJr0EEmZJG4Qf0SXb+zjOTh2adxhuJCRO2LBgis?=
 =?us-ascii?Q?eq1AeNQyuJGePSeODdwFSQq2C+HTjmnticWoaisOUd9uSPFUT17c8SgAx2lk?=
 =?us-ascii?Q?YJ4NJuFtEJ/9QH7KVy91yRLIWylaOG7O8gwTpzbq//Kv6Z+DvDzuBaiwVQF6?=
 =?us-ascii?Q?weZHP7/Ulwf+R6rMJFBWCFqfLkaaJTPWLaEsdwv7diKtJH/4VjMsBmT9sXUq?=
 =?us-ascii?Q?g9wbr6CI9rOy+3YvZ7yjasVsJX+igH0KBxmdjIh4GXzgaug7FtQvTwynJOCx?=
 =?us-ascii?Q?LthPGuwXezasU/qu0kr9rSAtHV28PWc8syMZZRK+wh3mRv1CNk3NJr6zrrl4?=
 =?us-ascii?Q?MiR/U6G455HrhoS2Uubp8zDgnTYfb+mfmVbALEVb3IpwORQxBHx8AO0en3e8?=
 =?us-ascii?Q?zj6ewHeiA+037xf9VOL0PswCcozKIIMDB7Wxbs5y45p8daLrxiGeCrxYLvQk?=
 =?us-ascii?Q?tGbeakORTXy5Mv2rD7BMXixmBu6/ALLb97MtkipTD6qKM5NX9gCZpLduScda?=
 =?us-ascii?Q?IZyFeOeEXNJhFSs6rUOaR2zVhEf2qXscG/fQ0/ly4T//Zut5LQf6Aj7eiaQT?=
 =?us-ascii?Q?nMeA6e0RMPAt5ej7RWzAYF+CI1/HGoiUNJybXvhLCui4OzJAq9rL2qq1Flr3?=
 =?us-ascii?Q?na+foqKjtdZ2yXHat9XkNDZUNzusJJSPJTWycbbia0hkjhBC8sq1MZBOzjeL?=
 =?us-ascii?Q?BHlOydtQ3ZBN/eyj9jWnZecKkgRZxiquOyayOsypd0G3tDcwb2h5H5SvlXiB?=
 =?us-ascii?Q?9Ks+esD98TYVpgNTTqukN91anHX9dgAND2KUVg/A2cw130xWcmeTMt0edBxE?=
 =?us-ascii?Q?tEBJ9u1RmDr/KqQFuQp5DJW4JJmOVx00ewuACoA3EXLgbo88BO1agyS7/rPF?=
 =?us-ascii?Q?lE/mT4F8AUA/KL3Koc3zDrzSNEuJryDd2chnPWXRHLzYtIY0Azqc+APgx2Fc?=
 =?us-ascii?Q?eX69DSkA/6xAFMGBFS9osvIDH84+HN8VA7jAcI3j/tndFdIkss6MwC5Qbjim?=
 =?us-ascii?Q?lQFyj35V3JwTweu6Kw/QCRLewjd4pGFqKaFNfeyDigxc6bVBfxXMH5leluRW?=
 =?us-ascii?Q?eiwmkNaC/kTXg1icuI0xwY4bsTAb7WcTMic8iJD1V8roJ5wFPwChG0AkuzwZ?=
 =?us-ascii?Q?RYTl6kV6xCJ1n6r98D4Odsd4YcsXA/zimjqLBGXJ9O24ZeNor4gBohg9zPp2?=
 =?us-ascii?Q?dv7FUmuuCs4uvK96b76sE16VBiqFLC/Jp/OY1w2mI2cBn6QCZNBOY3M4AW8g?=
 =?us-ascii?Q?CHh6ZF3cyN3XOc2ZMutgr5FcBQowsbvCRV74pcMy33ckQ6JlfGEpERu44Y7m?=
 =?us-ascii?Q?/IVXJavcwtrYCsgeVnvRWlLPp1WuE8Z9Qdw3lxMJgBS+XsQd4rrKiO9kbyCM?=
 =?us-ascii?Q?HqlS60JKtUsyhfKeNwYj8n6jdIUcdoTYzarQQT0omH3gn32DmW/qT4z2Rp08?=
 =?us-ascii?Q?9ocvEAGWz1Sj4mmCs3LniO6ASPi+0U/k5qH2fZY459xK3lqk1cwflLywTZud?=
 =?us-ascii?Q?LNrCqapSeWEOjTt9052BhaXlTcrKZCuZRiCoVwzKVOjKMF7MiGTAH8FXj1Dd?=
 =?us-ascii?Q?BJYcQB9PBdGHZ3HyY5LzQgOg/NkJF7T6SirwRUoI95VgOFt/7/MDrLDIy08/?=
 =?us-ascii?Q?sTF55o74bYRTZ/u+QPMuuFdIuFgQv42PhyQ8kqdgMwKniUjP45LUqk/xq1sR?=
 =?us-ascii?Q?iqBHE15Grg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e12238e-f913-409a-4278-08df1e11f99d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 10:11:06.8867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgWBqZF0BzP6cgxczmMy/a3ILoWNAG5FToEgLSK162pLLBbWW/sC1vd9n9GH+z8cFwAjFyiknlIRYQrJdFa2Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9752

On Mon, Sep 28, 2026 at 05:56:16PM +0800, Alison Schofield wrote:
> Mock decoder reset clears the DPA skip before releasing the decoder's
> resources. This leaks skipped capacity and can cause a later DPA
> allocation to fail with ENOSPC.
> 
> Preserve the skip until the DPA resource is released.
> 
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  tools/testing/cxl/test/cxl.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 62bd92b3be45..aa140307e0c3 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -913,15 +913,13 @@ static void __cxld_registry_save(struct cxl_test_decoder *td,
>  
>  		cxld_copy(&td->cxled.cxld, cxld);
>  		td->cxled.state = cxled->state;
> -		td->cxled.skip = cxled->skip;
>  
> -		if (!(cxld->flags & CXL_DECODER_F_ENABLE)) {
> -			td->dpa_range.start = 0;
> -			td->dpa_range.end = -1;
> -		} else if (cxled->dpa_res) {
> +		if ((cxld->flags & CXL_DECODER_F_ENABLE) && cxled->dpa_res) {
> +			td->cxled.skip = cxled->skip;
>  			td->dpa_range.start = cxled->dpa_res->start;
>  			td->dpa_range.end = cxled->dpa_res->end;
>  		} else {
> +			td->cxled.skip = 0;
>  			td->dpa_range.start = 0;
>  			td->dpa_range.end = -1;
>  		}
> @@ -1001,7 +999,6 @@ static void mock_decoder_reset(struct cxl_decoder *cxld)
>  			to_cxl_endpoint_decoder(&cxld->dev);
>  
>  		cxled->state = CXL_DECODER_STATE_MANUAL;
> -		cxled->skip = 0;
>  	}
>  	if (decoder_reset_preserve_registry)
>  		dev_dbg(port->uport_dev, "decoder%d: skip registry update\n",
> -- 
> 2.37.3
>

LGTM.

Reviewed-by: Richard Cheng <icheng@nvidia.com>

Best regards,
Richard Cheng. 
