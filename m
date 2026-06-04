Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011050.outbound.protection.outlook.com [52.101.57.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8485409130
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jun 2026 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569916; cv=fail; b=eL4+SqRn8ExUMWizOlPdZiYXXgitVsUkNNRPRAR8tZU4vqKfAxyqS7I8CX4xhz8ncm/McWZvQMLl8vawr1lA+Hwel3y2fDIg15WC+5gzCW2Pe6RFvTWpo6B7ZGc61fM8xdrv2Mw7LObdEzmstw65sP+2U1iYVBueyRuQ0N2enZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569916; c=relaxed/simple;
	bh=iJ7Yv8iYhBDJ3KANHd8XhcvoRVO3YHqD8dXAawNLcbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bYuH37iVxxzDIUxgcMXRDQMuuWFqkimUcXA22GCscsOHgK8C98HSI9vdEilhJH4JNxTmA7EJvvN6YW2UT1JsHrBKNzAzzGnfNLiT6lzYsi4GWZl/TV/VjRU87ZTZpfe+xax6BYA6tXBSjExuP5NHjvTFD1wTyzOc+oTQ6Biy6Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hRHWSJ2l; arc=fail smtp.client-ip=52.101.57.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hRHWSJ2l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tD3/+/LsQ68mmRSKuqCA464NCd1s946FR3GXfOLXjzF0Kw2jfPy9cmN+EHsHzYnrXV7PaEFRlJ58mdao9W3I2AYGRtOvaH5qP8LUJJ7ZHnUBztrkjkI+teKCW/1cpumnV3ymjKtudukbojNB/dmcVMapDsIm5FvGxr8DHCEhx+hz5LGxYi+Uu8GzKqiaQ1x1NTdIPh9kZB6GRN0SMQr7SOYG/9dVsk7nFfnucrrTTR145C68yjB0k/ROCBrkBV7fUC4iGlWNShRj9fSJy8vUkhP9fBeGbo6wFly2TKf7nCpu3dtnxR5isY4Q/U3I34aUOg80BdB+im8cztfGZyy+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y31IQ/kds8t4IFCzsxUVCuHDg4q3bgL+AGMWnIAvoZE=;
 b=wQGISeRhBnQn4ntaeI0ELah0buC4fJgfEg2wlHdHYo/zGuNX4GliLX2xuJ20GgCpqQUZz7u4giRhr38W+5obicuidg2YEifezrNVRm3zdhpUWlPEBYjj50HQ+WKFfO+autbF92/Ibj5XsxQ3n/ZC26DZx5nPi61Jz3iCSIrIfa1FcwgIxzjGbKVlXZXUrLNF96XE/5QPqPJ+zjq140luGjX1ZJ+ae3YcuAh0Ijox1rkd6IM5TBJGXTNoB84/pHcT/vkNCo3Hp9ubPSakjYcCHfsEbT9Ozv9HsjMvi2VVETkT+rHsTckiPN99re7HiIK2KsSyt7cV4jYTpdMcbtnmJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y31IQ/kds8t4IFCzsxUVCuHDg4q3bgL+AGMWnIAvoZE=;
 b=hRHWSJ2lGCqooV/VZqeta0TeCBoXRThdkcI0bk7fge7V3IRFB77/zJltVbnApDBLvGRvr66KaKJPunUbSbneOl2oBwhE7FDwu3K5j9h0Qe60o9lhYQkRb8SQ+g3q7hYZxxr7kvx2Iaf+onpOcOrke6xH6O5bNiuPwD5//w2rK9mydPYVsSJUHZFOBvUv+Rqp+Xazk5/ys5K9oK64KAYmElGIR9PcLmclA35BW4NpPgfay2fH29h3MNNZ6tR3F6VCp21RVEYwU10V1P/Hfs/IfR7pZVQXnAxiYOtgpp4U5QwsXFyd9id18sd6PCYgwkScqjDTsMvJmecY5JsNQrR2pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SN7PR12MB8771.namprd12.prod.outlook.com (2603:10b6:806:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 4 Jun 2026
 10:45:08 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 10:45:07 +0000
Date: Thu, 4 Jun 2026 18:45:00 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, jic23@kernel.org, 
	alison.schofield@intel.com, djbw@kernel.org
Subject: Re: [PATCH 1/2] cxl/pci: Fix the incorrect check of
 pci_read_config_word() return
Message-ID: <aiFW7kG3bPUzbHce@MWDK4CY14F>
References: <20260603185752.4149725-1-dave.jiang@intel.com>
 <20260603185752.4149725-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603185752.4149725-2-dave.jiang@intel.com>
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To MW2PR12MB2380.namprd12.prod.outlook.com
 (2603:10b6:907:4::32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SN7PR12MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c0b4a2-52ac-4d01-58e0-08dec22656e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YyQ4p5gfYSekwj62aZt+pRKLLK7SC28RCiWmuhn5VI3jnsXjB1xF+dthiHbp1M+p2lDmkAA+ViYNI8kgDbEzCrs8YFN5ug81BXCc/82HRIboygSAuMvncNhnSh2Jr5E/3Rqhf8vjU8QJOTifAyrdaTxo/n3fTGNNoSm0gA1SvWBwWXm5TZsI839BBG9xVIOO/A812ctyLyLMz5raIP0oxf9WXpTEfuiq+u2s8XUzn2M+lTVHH/Qba4WT0bMswaJNOMJs+Ql4ArGRAojDoJGzyomGeREWrROyyAKsbpqWMg9bijuDPcXsz7b2FB3BwkVvyQBD3rdgDHk2hihNAcmI2yHXPcFEoutSC2ya+CkvAKBwViXYZwTNl9b4B+5xAQTwFLCw/S2IxI7pdHU8lXjoSmYpiCTORu1OYwEcRKRvPjY4712kOBdkuz+gpskZ4yun+GW9M9tDqdQgOAHgBdzzi3Nl/e+0ucKip1yqfNO2WX7kVlq8WLWTSIIlxjE+OWCnnC8ctej2d3Wr66WXQx+PiaQBM4H8/05IO3KIgHdzowvRedBoSyQSNjjnGQZoPcdpcpFspbahgma3HBvpj5H7cDKbSE0I1ZVpPRjlpy93o9JoakglWIZvWoGGWSRmtDRajthLqsRVo54C9CYoBJvmG2AYe+7UyOXxU1jU2MMWePDl1yNAp6SJc6+6ZrBI8Kyn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OfjaetzqAhmutHzAmYiWqF5ecIO1qnjbJSM0bMEvXe+uQxRDkb8f8kf2aZn4?=
 =?us-ascii?Q?hcS+9zPkxXrMLgdxOYt1jIEzm/PFzPJanrFPi8XKuwGTlQ5ipzOnlfUd+rWk?=
 =?us-ascii?Q?m2YecjZpO1qPB3SHzPREmFr44VSYmiLQu16u+yaRiRSwhHpgGbMWpQ/lPCil?=
 =?us-ascii?Q?ggd0TRLXKvfcCqSac/aC0u4UU9oqprkTWPxC8VK7YoCY+IVuKE6XD+a90eY4?=
 =?us-ascii?Q?2LQERdekITlvUqoj2mEVi8P5ci4GeCObiQQ3MUi91zkZ9FWD26xwOM07dk7O?=
 =?us-ascii?Q?EXkp25nznAdnPillxIWVOfL9H84yK9jmd4Zxp2YNqcAQzCoIkahruNnESQcQ?=
 =?us-ascii?Q?se9Pj7OrdFlfeEGOAUFhOhqB5ys4Pm3cRTK4xcHuppWcp7R9Mifv37fXuNwM?=
 =?us-ascii?Q?bnFwPUwS9eCu98zKMdoLmDCeYHAk9yBcVu5VG200dIwdo+c8ivs/YOe14U60?=
 =?us-ascii?Q?g7O4yY72Gf/Zn69Z5QPMY5Kwgz1iGtG5iQYKo1q/y1ivU1iiwvKC0XGoeXkM?=
 =?us-ascii?Q?m+TlI5qEh4AtcnpmYPIFm+0+U97rN3YmgT4KQxfu0kwSSRDcWcc48jvtRBuh?=
 =?us-ascii?Q?pjzaAo/caXm3+KX2NbdCyigyP4h8DqZNzmysT02MJaYUy6eqvpGcffeosYfe?=
 =?us-ascii?Q?RW7OqoDMY5lNz3DUEd/GNqDnolpUJ15h09EvnBzMD6HOSNu46gjh8SmsRojV?=
 =?us-ascii?Q?60y4sH6XQIOaWN+684Ijr0FoE5U0DxPLaGXOHN76OJL6rBaadP0G/VsJVaMe?=
 =?us-ascii?Q?vT1DuzmuHUzfakaw9KBZ5K2eixN/LQ/v3YIG4BwOC5h38dBzZWmEBEs7cohs?=
 =?us-ascii?Q?m9P1/0HOEc67aCDos6kcdckykd1LYkfUjPWsmJX8y8gxA+uop0xOdxt3e9Hd?=
 =?us-ascii?Q?n9/c9j1BExcmvYQHAgpLVvouWugTcBhJU7GsDC9/lW+kTyhykjp23LIBySl2?=
 =?us-ascii?Q?QeZqki43O+JXuUHulbbNUIGIwU9PGeK6zFiU56Hb9q/U4CZeVBo0VsVBZJXU?=
 =?us-ascii?Q?epr7dwioZD1F371PI4uxhMJTsOv8mS/ZrwDaL6lhLe51k1y5/Df/WtDxJbyw?=
 =?us-ascii?Q?Sc3S9Cm1EAXF+Aq3TWdoFAHNpQ9OT0gd7p/3UyTYjDlfoXK3BqL4WW4Arv0k?=
 =?us-ascii?Q?e2InK5hiSYrgYlzS6WzVygo898LSeFLTOysOQTgDR+w/RIbHzRiTT5rVAagk?=
 =?us-ascii?Q?XydA43cmvNFLN1zRHMDWKEV+dI4B06ygGONG2qfde62dDg5n1PXqktKdCrIk?=
 =?us-ascii?Q?RXyay7LqOKc+Cr2u1cV05mtv54rqjD/THTecTVfspDPeitEldxkvtIYP7Izi?=
 =?us-ascii?Q?11zGSHnZj1Gs5gnqWLvYHmMEU2eLkqIBhoFhjZejprOwKaPi2Yc+XYKM2x/h?=
 =?us-ascii?Q?DtT7ZBGRhyB8yBwKrYkPk0UwxNhhC8PJwNFocovthtEggkaW8dt4XKicOYUb?=
 =?us-ascii?Q?duBiNZ5iDhPTOAmGk1Z241UeXeQIy7hlIOLkqREPMBOr61lO1StjaWgbF8be?=
 =?us-ascii?Q?xs69bblpC2+9aYIA988jb6bnUZgXvza1/TeD51qqd2ClQ0Fxq8GnaDknfdyJ?=
 =?us-ascii?Q?H4fPKW9ZswQMBoyTUrjki8LBVrNoDQGA03CtC9rDfOhor3rWq9XrkxGDV9Pv?=
 =?us-ascii?Q?kQ8ow5jsnZLZPrW9xblizeGkUE6ah+E3p6T/NaERN/N0VfApNLR1ytjofH1A?=
 =?us-ascii?Q?3IGRZ0SMMQkqLD7rwuffje13ygxsAYJFkCg/P6BoYdZIIL37KJrLS1G3Ynti?=
 =?us-ascii?Q?cT/+YJ+THA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c0b4a2-52ac-4d01-58e0-08dec22656e4
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 10:45:07.8269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ba4dpXSWxgQLr3SzvkoDifsRlo4ULTnwLkuBw4KRSUtGEuERDw41lNHUc8duoDHt8WQTWcHJiRt/oLNkZahObA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8771

On Wed, Jun 03, 2026 at 11:57:51AM +0800, Dave Jiang wrote:
> pci_read_config_word() returns PCIBIOS_* status on error which are
> positive values. The check should be for non-zero values to indicate
> error. Fix cxl_set_mem_enable() to check for non-zero return value
> instead of negative value.
> 
> While fixing this, also convert the error to negative errno value when
> returning on error path.
> 
> Fixes: 34e37b4c432c ("cxl/port: Enable HDM Capability after validating DVSEC Ranges")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index d1f487b3d809..43885c59a7f2 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -187,8 +187,8 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>  	int rc;
>  
>  	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, &ctrl);
> -	if (rc < 0)
> -		return rc;
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
>  
>  	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val)
>  		return 1;
> @@ -196,8 +196,8 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>  	ctrl |= val;
>  
>  	rc = pci_write_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, ctrl);
> -	if (rc < 0)
> -		return rc;
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
>  
>  	return 0;
>  }
> -- 
> 2.54.0
> 
>

Reviewed-by: Richard Cheng <icheng@nvidia.com> 
