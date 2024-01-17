Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750D21F922
	for <linux-cxl@vger.kernel.org>; Wed, 17 Jan 2024 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705497804; cv=fail; b=QtKNVe7xCaUOFvCmydcYd/fxSLAKCl4jJQvPJaHQkNLdJ0I9vMXDxi9L5qaOf6EdPN1lTxKs3vWD67IdJjaObzt2JF6dJ6kvvq7+9WJTNHBoF59Y1FOnVhS3bp20qbJT7ECt5xUDcNMbeeZHLInvhwmUjQLx3o+FHTqp6khPr28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705497804; c=relaxed/simple;
	bh=Lb7iv4btK7ES5BvxSfvNyKXSOgKxgQ1XclILj2aqjvk=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=QDo8r4FghEUwFy1aZ7R+c6SJW7ikjCZR2IFih1m48zf+Tpd6fo/63Xa/hgNFFUai/61+PFZO0K1vJ6ezFWS/Dl5neZFlAJpswJ4UVOF/vLN5PnIo9CtPY9GHk6J2qYYH0fAUszhktcLRTKz51ApUUskImGZRv2YYcmcMuuQEC6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=okYmNUtp; arc=fail smtp.client-ip=40.107.96.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="okYmNUtp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfgYfGcBQHSH7YdpRL7+MfvfYw8m1NBOtGVGYKyLOyM7Lk1irCvQawcEkmFLHgEWg9DQT51105yghsl7lw8rvIJJy/InZKVuR1KFvjP4XeGHWd++s/miBCheI3tO0LOS+eD3CjZjRzTJG40FkHhBgYvz19/2nFrS9XV/eepF88Akpwa55FtUxoP00vb/YdAoCIH2uy9NBQuZp9XJfKQU9zeLJOPnagLh7DQ82By+mchGDcUB/RYA8HKWgFFw0F5BQbgWBWjF38Pc5MKOhR9W4j8W/CyELDFrQ1zaoNVg1YPwHsJ3qyQKvL9w8R3cSpQINqYYiiRjgsaoEHXWW2ZdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ht1NbkI3Zbx4xgtxAHWPvvE3PvTAXP1oX7bL6gPEoBM=;
 b=cS+318tmJhGD4MPJJKS/87brAFu8k7EYutWUQLyRc3Zx1KtEgouBeWlp13IVkAo2k5AKPWd70thQK/ukavcEbjTye/fCOo0V0UIR7KL4WywxCroFgQMrxorQTvm9UXtOjOP24w4XLD8QLgUl1yHwVDygaC8+CwQmYwvqitePWBOnJLH5z8TlzvGBf+QAZ7usmW09MgHfZUMCASQhGjeQwDuvFEjY9legsL5t611QVoDn6DFzYfl9cI1Y2sYcvHd8VjxvVD9PZ3l/cXJy0k6oXqBjZrOme1CnAAUc78kwaEXfXPzfPIhRd79UtUNb1xxozIoHl8EBVe9AspOZuF3MNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht1NbkI3Zbx4xgtxAHWPvvE3PvTAXP1oX7bL6gPEoBM=;
 b=okYmNUtpMmB+3bT+dq9SLNGm+tES2Ic02dCzi1A7GR2K30a9wq+io5PwYrcGfqyQR61YNz8ReKtlY1NUaDOmKcXoV+gkqfRiUbH8RmHi6IJWMBFVhP7mt7+WyWJznAlNCJrVYjxs+w6GVgPx8LMq6P0nOt7UNpJcTyuV4ZBbUis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Wed, 17 Jan
 2024 13:23:18 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::e46e:7c32:7556:fae1]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::e46e:7c32:7556:fae1%7]) with mapi id 15.20.7181.020; Wed, 17 Jan 2024
 13:23:18 +0000
Date: Wed, 17 Jan 2024 14:23:13 +0100
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/pci: Kill a goto in read_cdat_data()
Message-ID: <ZafUwceT4N-bmS6F@rric.localdomain>
References: <170261791914.1714654.6447680285357545638.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170261791914.1714654.6447680285357545638.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: FR3P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::12) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: a607fd6f-6ec6-49a1-f160-08dc175f77d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C+s8cXgxb4d1/tbPEYnWcp2P4pSiLyx9yZoiSPHN1ADU0SSu1n5ERE08sSc48pJtABvWZ9AX4ILIMVV+zEJnZaTCSCDAXlNw8A9YjfQYxUrWJK5Lk61Maw8r5Wp7+rzzE7i773oS3E8mFsmo8ezR/AYHNbVxmUjPh0cCQxTFTUgBcERx5O1Svh/BdBS6rgqrjjRAsYH5ztjIBMR6ww0+xRxUQXpbCSXOXdvnqOOAEVptyR9mhVhHwQZaPyYm/yYX8q2jCBszH2BiCDhd8N84QHEuZwRkgVJxqn2BJyDl4JMMuNtD2n+lzZhfD7kL7PTUpV93SXSWUwYKjrPPCkllKKLB4Mt3LRh0Qmd6glBglv3Wi2bHhJitpf2OnEv26/xyAf7lAvz297I178+OyVsz7wOizUItO+Hzsl1tme58RffzgHeecNXr/fa4tib8HI4UMziws+9rDzn4mY0YsC2iqscVsb0/HL1YYVO4vuWTdTFMH1uJaaHgkPZvcK7vWdg8b7EWSNgWHpGQnKGzlFgbt+FpmT+FatSWKaa8EpylpECy95o7wMXA7Rp99O+q6o97
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(136003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(5660300002)(83380400001)(38100700002)(8676002)(4326008)(8936002)(2906002)(26005)(478600001)(6506007)(53546011)(6666004)(6512007)(9686003)(66946007)(316002)(66556008)(66476007)(6916009)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XFIJMbgIGJ6WQBjV171x1RFnydEC+dLzBaY9BmoNEQT4kerg2kvacOEl9wUG?=
 =?us-ascii?Q?SKTpchwMZCCjZoRr6sELBi/WtVbx2e9K9brzo2Om5n8qrpG+GbUwGNLZGwgj?=
 =?us-ascii?Q?LOg+v8Ikis1nnwlbZ1sQOc1ECwhw0IPqJQow/7izb4MNtxeXX1HjAt5NcDs/?=
 =?us-ascii?Q?2xAJkj/hIMWgODHlkAzc3GXzzP2SGDrGgIHl/LRDpiIpWH2OEOSMWSNIsaBc?=
 =?us-ascii?Q?8clhX7h5SJmR6tAlRc+VorXwvTyt+vJhcaaz8oOZUP8n11eznK6d/Zf2tSgC?=
 =?us-ascii?Q?rAs7UBYQhKNNRVAu1/hEG57b5msjp92SPohQx6QrHkefew/njeO1+gZ4UWcA?=
 =?us-ascii?Q?jlOYgrR/YAKs7f+FPU0RmuFflHmg+kfJyEdBGBq+2Q10kobErh80PAEO644+?=
 =?us-ascii?Q?yJ32tC2hiKwPl/BN9SjiDZYz/A5ySFS0IyCahzL+w6GFaJ3mw5JcRBPXn0GE?=
 =?us-ascii?Q?5I0GvaYYKPVljRYe8Iw1ts541R9XpET4Wm3gMk53pOnsrWago7Y6ocmK87Pb?=
 =?us-ascii?Q?RfxVyxmyEMgc1u88s45gl+H+rQL8ZzZBKxVpVVZuqOko22ED1JcZttcWQn1l?=
 =?us-ascii?Q?rA0s2+sFf0+UuNTIpslW0rmi/BSPhDPt+g9/MFTLD45nzud/7u+MSQG3oW0k?=
 =?us-ascii?Q?JSDX1yQfScCAVly4Tkmf/RKvhmBgVDWrjXk4PGggRTc2VfKDgulOYpt4Lw23?=
 =?us-ascii?Q?SPji3SGPLdpUzaeuXsi89BBs0ZRTdPLDzt/AaD+rdzKmMuxVAC2aOefgFwSD?=
 =?us-ascii?Q?CUTP0FqJxsEqzDkRU5e97QU13AqntKMc8U7a9xqeFRmHwQ6bH2igLi3jy9Im?=
 =?us-ascii?Q?tq54LAPAfoQq7Wjb3062xuO2F9+ovK5N/aTV5Bb4ceSdMswwZJ7b4a30DqY9?=
 =?us-ascii?Q?t408vYj9I/5nXHhApTjbMXkubAnCH+Yfv8fHv+ZmLXddWs2bEP3sk6tva3ZK?=
 =?us-ascii?Q?mRgw1Fvay3O+0QB9TWqCG0gKp1O6jzwLS0t1Lmi+lxRKrygMCPuW5TGM1IU8?=
 =?us-ascii?Q?37Mt9Tp6KktIGRhnOv6m3/TUCMcc62QSXZ43eS+VY840Hy8T4vXNBvD4Li1m?=
 =?us-ascii?Q?UkCzB36Y8v+eShCeRwEMPiKWPUUv+equgaUtZ/4eHJmq1qShaVetArqPVozB?=
 =?us-ascii?Q?+H838VHrg3XaSuGYM54vqcTJIZE+lhbnbMOQY2QPS3hEfR99Q47+xldWyTMd?=
 =?us-ascii?Q?rcUlZMjCOMoP2Y0h174j9FIW3pvSN4NC/E+ktR2jH4JaZ5l4YUM1dCp0lElB?=
 =?us-ascii?Q?bSM8dqLHAb7xZHaMYzaYWjqVcUQopSuyPAeHYe44kY/IuFjWgu5d2hx8zaZr?=
 =?us-ascii?Q?jVrUsIzSj6xmcDcPg975GuuNM2adA8jduKvoWuRnh34yllssjZ8CYorpG0ZB?=
 =?us-ascii?Q?Ftv8HEsol8FJqcJ4JlTs6HV2pY4SVlS1PM0y6c+AwGYx0vyUf9QYHYk1tHmG?=
 =?us-ascii?Q?tHdM+/Sl93kiy3k0DSQJWYRkYyQch9qokRzqqBadNIEV+0xpXxQHkFSVSd6g?=
 =?us-ascii?Q?70RvnT/vzhQjeHI5Upu/t9gOb4a86o9ybs6fLYk08MIfLzjlovjfpuThlh5u?=
 =?us-ascii?Q?JT2VORPbMRaqzHV/EBe7BI+GTBAdyQhmW+U5sIkl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a607fd6f-6ec6-49a1-f160-08dc175f77d0
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 13:23:18.1931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eez+msfwn/Rtrk2DRd5QRBZU0ma+ockzKj+QutcEYB+uUa+Q58d9MtxSSuSzmYIUq1w45t6RLub3dnNhKpVuiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253

On 14.12.23 21:25:19, Dan Williams wrote:
> Given there was already one bug here around passing the wrong value in
> the cleanup path, remove the goto with the use of the __free() helper.
> Note that since the cleanup helper only passes a single pointer as an
> argument the auto @tbl variable needs to also include the @dev argument
> to devm_kfree().
> 
> The open coded math to shift the port->cdat.table to the relevant part
> of the response buffer is saved to a follow-on patch to cleanup.
> 
> The "devm_buf" scheme can maybe move to include/linux/device.h one day,
> but the expectation of using devm_kfree() in an error path for the same
> function that performed the allocation is a rare pattern. Many
> devm_kfree() usages are at object mid-life or end-of-life time, not init
> paths.
> 
> Cc: Robert Richter <rrichter@amd.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/pci.c |   29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 37e1652afbc7..dd938a60a2de 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -606,6 +606,12 @@ static unsigned char cdat_checksum(void *buf, size_t size)
>  	return sum;
>  }
>  
> +struct devm_buf {
> +	struct device *dev;
> +	void *p;

Maybe just name that buf, the accessor would be rsp.buf then, better
readable.

> +};
> +DEFINE_FREE(devm, struct devm_buf, if (_T.p) devm_kfree(_T.dev, _T.p))
> +
>  /**
>   * read_cdat_data - Read the CDAT data on this port
>   * @port: Port to read data from
> @@ -614,13 +620,13 @@ static unsigned char cdat_checksum(void *buf, size_t size)
>   */
>  void read_cdat_data(struct cxl_port *port)
>  {
> +	struct devm_buf rsp __free(devm) = { .dev = &port->dev };
>  	struct device *uport = port->uport_dev;
>  	struct device *dev = &port->dev;
>  	struct pci_doe_mb *cdat_doe;
>  	struct pci_dev *pdev = NULL;
>  	struct cxl_memdev *cxlmd;
>  	size_t cdat_length;
> -	void *cdat_table, *cdat_buf;
>  	int rc;
>  
>  	if (is_cxl_memdev(uport)) {
> @@ -651,26 +657,19 @@ void read_cdat_data(struct cxl_port *port)
>  		return;
>  	}
>  
> -	cdat_buf = devm_kzalloc(dev, cdat_length + sizeof(__le32), GFP_KERNEL);
> -	if (!cdat_buf)
> +	rsp.p = devm_kzalloc(dev, cdat_length + sizeof(__le32), GFP_KERNEL);
> +	if (!rsp.p)
>  		return;
>  
> -	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_buf, &cdat_length);
> +	rc = cxl_cdat_read_table(dev, cdat_doe, rsp.p, &cdat_length);
>  	if (rc)
> -		goto err;
> +		return;
>  
> -	cdat_table = cdat_buf + sizeof(__le32);
> -	if (cdat_checksum(cdat_table, cdat_length))
> -		goto err;
> +	if (cdat_checksum(rsp.p + sizeof(__le32), cdat_length))
> +		return;
>  
> -	port->cdat.table = cdat_table;
> +	port->cdat.table = no_free_ptr(rsp.p) + sizeof(__le32);
>  	port->cdat.length = cdat_length;
> -	return;
> -
> -err:
> -	/* Don't leave table data allocated on error */
> -	devm_kfree(dev, cdat_buf);
> -	dev_err(dev, "Failed to read/validate CDAT.\n");

An error message is misssing now. Could be implemented after calling
read_cdat_data. But that duplicates code.

>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);

I am not sure if using __free() is more safe and better readable here
at all, it introduces more complexity hidden behind macros and
compiler behavior plus an additional struct and __free() ordering
issues, just to remove some gotos.

I gotos are 'bad', a helper function could be implemented
alternatively. On the other side, the existing code look straight
forward.

See the 2 direct comments to the code I made. However, the
implementation itself looks correct to me, so for that:

Reviewed-by: Robert Richter <rrichter@amd.com>

Should I rebase my other CDAT patches on top of this one and send a v3
of it?

Thanks,

-Robert
