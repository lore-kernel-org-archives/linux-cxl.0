Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F3B241E0
	for <linux-cxl@vger.kernel.org>; Fri, 22 Dec 2023 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hr/mYGGF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703260722; x=1734796722;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V5yfL3i7nnmTr34nr0l7E6m5vuIYwjf+Ds5JDogndEo=;
  b=Hr/mYGGFOBuL1H0fkRQ4x1BY3B73n7wuZrAulrPpEg68sfnCc9psmNIy
   7xzlZ2b9rexITx51aGBa1I5yqCE2nS0o3OALDkzYkWkZWnxcCvtnMuKD9
   stvoTqj7kAek1Tu2xmpm7EOlR1UEBIrKPuis73B3XUdG3q7A7xrAS2c2N
   SPqZ9d/O6Hugbu8nwIFH7hXd1TBFTI534eakhw1rG34k8BBoHN7y4uVBT
   t6DQTJ6rydaCLS+6Eaz3gEqpUHF1u3Nvp23jEEOxPG1xLJ2mLgwpnZOOb
   ZrJ3sA2cqnJx71D2k4Mny3o8n5acHKhvwRXcFmIHcuzSh6GWVkGThBnif
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="462567374"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="462567374"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 07:58:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="1024227630"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="1024227630"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Dec 2023 07:58:40 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 07:58:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Dec 2023 07:58:40 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Dec 2023 07:58:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dI8pIh1eyTNo64GVclh6qG5pE5igweLAaUIIBoT0MQM8CxdJNvXiKFLHuZb7ldb1G5r6eo01r0FOhzgX0cOjWz48GtGzz+WcRrzi/PjTpnBE05lwRsbZkV4MHW/R88TrVzMtkxMA8/DLzRSq3o+GH4bHHxvmTnjSLSvaCwFJ/X4Q3U3fg1Z1e4fB/RXMBSqtRnV4w9FsA7MfIqMV6kq+fUH8pHkxe0XpogSuRPg8byBMRt25qiFDMR2w6RjTvxctKICYdUxg4F7mNbkO+RgJZedrezgYl6IHfrZa45qPxHfWhyPnoym86GnQtilVFrmJ/5MSGd6rwu1uIAySsVyfkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qA7W304HpFOOqLI79QEPOO8Oxcym3L8sgpij8OGaFEw=;
 b=SKlpDzS4cD0FJQtOAHVgrYiFlWch937KfOdGQc0RcItFCHQdSEwW7XGYcl9Q2IV9N2iQBtR5mKvpC8Pn9Up83rNdGA3b2pGmjmnqsBZ8g0yqpLo/0Xv55WiBYMTdoNL6c7M5SLhFXZSmCHdqLWLm7b6LnVDMETQrcjICXjRQweDymUkciYR4xa9UPQbExl+j6D8R95VVt5gEqdiDgIx4xzolCbkWvBcRBBVyJ/lbLVMHvE4OIdxu8GJk9DC1Tycg5NmnIMdppj2ehGR5eIH2E7xu7Tn9I/Igg+Wi6nw3VGBjAVf89xU1EVjskcaNxMwNbZKNndq50WbkIwLuT2OLTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH7PR11MB6607.namprd11.prod.outlook.com (2603:10b6:510:1b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 15:58:38 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 15:58:38 +0000
Message-ID: <651b2407-894c-4587-9a97-5e59ede7b6ca@intel.com>
Date: Fri, 22 Dec 2023 08:58:37 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] cxl/port: Fix missing target list lock
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: <alison.schofield@intel.com>
References: <170322553909.110939.1669280651596703652.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <170322553909.110939.1669280651596703652.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:a03:331::19) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH7PR11MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fcf1567-1232-4064-8f5a-08dc0306dc45
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wh6Bt+f/fPJq4X3Wftow/SgcvFcko7o/sGfdW8Kn2PUPg0emhMiJVBEXDA2oceViYKqtYVEdiEXCDB7adfmhPxMnng8MXzA/RhK56YUkeJpqDcVtyOVKgNQPfsE8+Wj9n43JP0UtiQe6MnTgasKmkfxhgLaCwRhiS0N7K6kmMm/0dc3R0uVPVlEie4NkYxGc9YPgXX60e74ajcU8UwslnmdSLk6ce+FknRviVILTRtZaZsNlWQnVH2BKXmoFyYRfUEbAMkVWYEFDATlbIuBSzNnFmxfeso80mV5r+lypHWr5L/Jz/NBXO3pF11Wnvu19hZsU7URisnGC3o1pbrRyHKAFjgfio+ExNyxSbDKcKWAjeTtZgbCCAyZ4ncA496SjXQZuGqn5Yw9aq5gem8dDxRYku3kqGsCPpBsG5p6aUVAOfcS1hOZXYE7QZnQWdhcYjObvOTKI15cTn+vJH8mtzL3EpWes8QsHLXXLnuiAIy7o+D2zhxJGgGWIPRaXzqqjjVRwwTrYpNw2WDGRZqW4g+jWsXm7jX3sK3fa6INN28AT/hSRFHd6ikaUXH5gYz4n3vuyEE77x5kdXagexZv0XCd3J7j9qpRmyxqZCFkmmlp3FX4T4NZUx3XBA302+Lim
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(26005)(53546011)(6512007)(478600001)(6506007)(2616005)(8676002)(66556008)(4326008)(66476007)(316002)(66946007)(2906002)(107886003)(38100700002)(41300700001)(5660300002)(8936002)(6486002)(44832011)(82960400001)(31696002)(36756003)(83380400001)(86362001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NENWZ0Y5Q3lCRUdya2tyZEtiUzNrZFdlb3BNMkRFWlgzOVNCbDFlcE00ZFZs?=
 =?utf-8?B?MmYxLzByaUlKVjU0U0w5VUJXR1oyNlBjd0hLR01YUitEc01aVDZtZ2NYL09y?=
 =?utf-8?B?U0pxT0lqM3FRbWtvVGZDT1kxVElMSHh0SmVwOVdrNkhydGtkRGFHUGZPajVx?=
 =?utf-8?B?YkNqU1dSVEU1ZnQ5azFJNkJUMkRDZllyeExZM2JmOE5TaU9IRmdpZmgwbUFo?=
 =?utf-8?B?TzhDSWtyVlFzVnM3dmw4NUpuTHNmazNXRUF0bFNHZmp1dFVUci95eHRNaFY2?=
 =?utf-8?B?WkNCMFRUK1RhbkpiQ2NvS1kvWGZGU2I2eE5oZGxiWnVOM215NlNGcUNwcFp1?=
 =?utf-8?B?MHg0bnBiOEpWc21QMm9SbDRhNG1ZK25qcmRhWUh4U3R6WW41aTdGZkQ0R21o?=
 =?utf-8?B?eGhmSDMzc2hNSlhGZWZIcjRUdVpqZ1dYVmhhdEZmbTU0QW5kTitaUm5hWUw5?=
 =?utf-8?B?eFRkeHVyb0tvNFBhSXpvelFCendPWHBtYWVtYUJ3eSs0dkhIZ1lKWnRmdFZJ?=
 =?utf-8?B?ZXc5eTV6Z2FCZ053dDlHRitOQjJTVWltdE9GUEVqdnpUZmtwWENUSWExbmVI?=
 =?utf-8?B?amdDQzJYQWJtckZuam1MVExSNjR5cjdZMkd5UERvZU9BRXVkK1lwUElQaEFX?=
 =?utf-8?B?dXh6MS9lYWhFNnVQT0lTYXB1aHhYcmhkYU8vMlBMMWlUMitEWU80RnphUDJ1?=
 =?utf-8?B?dlZqNEZ6UlY3OGk1SlZNY2ZUNmcxVHhSS3V6Z09yaEppUG5lQkhWTnl4MmVW?=
 =?utf-8?B?UFlJN3VQbHJvNzdxUVpEeGtocVc3ZTBMR0UxUkJqYk82UTg3eURDR3ZBOTlU?=
 =?utf-8?B?RnlCMlBJcW52SjMzQmRxZ3BybUVGbmQvV2JLZWJsRm5tb2hLMVRLSnFCWmtP?=
 =?utf-8?B?U1RGZlcxNE5FMy9TM3RkcnFuc1k0eXpPWFFJZjhUTFhuYUZRNE9uYW5oZzd0?=
 =?utf-8?B?OUJNYWlZNnJabEUrSGt4N2duL0dKWVZuZHl2QUdUUG8xeVJiRm1hQzFoZGl3?=
 =?utf-8?B?V0NndVUxeXp0RDdoNDQybVhXZTdqZ01NR24rQXJLcnpFVFZYRllnU2hKTDVV?=
 =?utf-8?B?dFVGZTg5bEp1Zzdma09ka2tpMUkwU2wzV3JlSXhPaUR2U0JCWHdpVDF0b1Bi?=
 =?utf-8?B?ejkxWXA1dnVROHRZWTlHcEkrUlkrMnlFRmZ1aG9uSllCV041Z3JaZ1picXRw?=
 =?utf-8?B?WlpnQTZUcFBzaythQzFxNFNPbWZxR0VTbE9JR3VRWVcyVU9GWjAyOHdPQ2c3?=
 =?utf-8?B?czcwTHZmQzRQN09DamtQTlZGaHg4UlB6VW9NM3RMeWZjWXA3c3JZbzJaOTFt?=
 =?utf-8?B?cll1WUJtUE1aWEFQZEpua1UwTUIxWCt6M0NSU3hzYjdsVDJ0MnlJT2RXMEZV?=
 =?utf-8?B?WDFkbTRaYUQrZTNzRHBFYllDZkZMMHgzYnBCK1h3NEpXSE9QdXE2aFkxYzJP?=
 =?utf-8?B?V1krcG8yRkgxY0swNlZjd0kzcFJycmRqRlN4L25pVjRZL0w3UHBwRWNzN3J4?=
 =?utf-8?B?Q3liQjNjRnlqUnVISGl4Tm9lK3lGb1Q0UXUyN2I2WjE1VU1YYjZyMjZwcmdD?=
 =?utf-8?B?aUYxSThFclc3cG9mcHNTTkFTRUVzRXFQbVJiNDBvVE9Jb0dEc2tVWWgyYTBG?=
 =?utf-8?B?Y1M1RmdNTVlrVldna1d4eFJTTkR3dkd6aDRJdkttSVZnK3VUVTMrSytub1dl?=
 =?utf-8?B?Zjk0TXZzVzIvcjBBLy9mSGRhdzFhck9oYmptZ3I4Y3BGL2RjR0NLQUIrOUxB?=
 =?utf-8?B?cW9keXJvUFQzanp5a3hmU3FnVDJ3bm1lSFlyd3BMaytzQ0gzQ3VmSWNYcldo?=
 =?utf-8?B?ek5uRFlpWlRTOGJKU2YrdXdhV2s5UDFjR2V4dFFxeVRYQWhIVFR4a1o4d1Ji?=
 =?utf-8?B?eHd3YXlaQVJlTzl6UGpkTmJ4dDVZdnpHL0thaDZ1S0FZT0xYYnJjTmhEUnU1?=
 =?utf-8?B?V2tSSmtpS0ZKTGY3cEtCVzE3Z1Zlbis4K3NMaCtWQVFGVGZGTXB0RWt6TDI0?=
 =?utf-8?B?TDJxM1pQYmYzREV0UVhjKzNDS3Y5V1JXYXBid2VIK3U0UkF6cWR2M1JvUFEv?=
 =?utf-8?B?cnp5WnJ5UW56REt0ZHBXbTUvNzdGVzlqVlA3c0FXWUpYN1VNWFcrQzZ4YVUw?=
 =?utf-8?Q?OzhbVJPXUVMasduj6NtEVerIi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcf1567-1232-4064-8f5a-08dc0306dc45
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 15:58:38.1586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFu2JbNg95BdNRiQFMlvDqutAt3+XMWSuhrR2O7FNdKt2Be1oVgNiZcOG4nKHoqbh0D4yB6BB55+06tCp1KBGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6607
X-OriginatorOrg: intel.com



On 12/21/23 23:12, Dan Williams wrote:
> cxl_port_setup_targets() modifies the ->targets[] array of a switch
> decoder. target_list_show() expects to be able to emit a coherent
> snapshot of that array by holding by holding ->target_lock. The
> target_lock is held for write during initialization of the ->targets[]
> array, but it is not held for write during cxl_port_setup_targets().
> 
> The ->target_lock() predates the introduction of @cxl_region_rwsem. That
> semaphore protects changes to host-physical-address (HPA) decode which
> is precisely what writes to a switch decoder's target list affects.
> 
> Replace ->target_lock with @cxl_region_rwsem.
> 
> Now the side-effect of snapshotting a unstable view of a decoder's
> target list is likely benign so the Fixes: tag is presumptive.
> 
> Fixes: 27b3f8d13830 ("cxl/region: Program target lists")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/port.c |   22 +++++++---------------
>  drivers/cxl/cxl.h       |    2 --
>  2 files changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 57495cdc181f..6b386771cc25 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -172,14 +172,10 @@ static ssize_t target_list_show(struct device *dev,
>  {
>  	struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(dev);
>  	ssize_t offset;
> -	unsigned int seq;
>  	int rc;
>  
> -	do {
> -		seq = read_seqbegin(&cxlsd->target_lock);
> -		rc = emit_target_list(cxlsd, buf);
> -	} while (read_seqretry(&cxlsd->target_lock, seq));
> -
> +	guard(rwsem_read)(&cxl_region_rwsem);
> +	rc = emit_target_list(cxlsd, buf);
>  	if (rc < 0)
>  		return rc;
>  	offset = rc;
> @@ -1633,7 +1629,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, CXL);
>  static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
>  				    struct cxl_port *port, int *target_map)
>  {
> -	int i, rc = 0;
> +	int i;
>  
>  	if (!target_map)
>  		return 0;
> @@ -1643,19 +1639,16 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
>  	if (xa_empty(&port->dports))
>  		return -EINVAL;
>  
> -	write_seqlock(&cxlsd->target_lock);
> +	guard(rwsem_write)(&cxl_region_rwsem);
>  	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
>  		struct cxl_dport *dport = find_dport(port, target_map[i]);
>  
> -		if (!dport) {
> -			rc = -ENXIO;
> -			break;
> -		}
> +		if (!dport)
> +			return -ENXIO;
>  		cxlsd->target[i] = dport;
>  	}
> -	write_sequnlock(&cxlsd->target_lock);
>  
> -	return rc;
> +	return 0;
>  }
>  
>  struct cxl_dport *cxl_hb_modulo(struct cxl_root_decoder *cxlrd, int pos)
> @@ -1725,7 +1718,6 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
>  		return -EINVAL;
>  
>  	cxlsd->nr_targets = nr_targets;
> -	seqlock_init(&cxlsd->target_lock);
>  	return cxl_decoder_init(port, &cxlsd->cxld);
>  }
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 687043ece101..62fa96f8567e 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -412,7 +412,6 @@ struct cxl_endpoint_decoder {
>  /**
>   * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
>   * @cxld: base cxl_decoder object
> - * @target_lock: coordinate coherent reads of the target list
>   * @nr_targets: number of elements in @target
>   * @target: active ordered target list in current decoder configuration
>   *
> @@ -424,7 +423,6 @@ struct cxl_endpoint_decoder {
>   */
>  struct cxl_switch_decoder {
>  	struct cxl_decoder cxld;
> -	seqlock_t target_lock;
>  	int nr_targets;
>  	struct cxl_dport *target[];
>  };
> 
> 
