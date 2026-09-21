Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013064.outbound.protection.outlook.com [40.93.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B0C3EC69A;
	Mon, 21 Sep 2026 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789975762; cv=fail; b=fiUdWr9gZFrmaXgmu3WUF0zbcNewl3wtzQSLXAEc9mg7iXz0YKRi0t01b3MzPhvlU8SVxCFpnOYzkoAYGRtzd1hG7PYsUa1nJB1p+r00QPKmihUNLKMujmcqqB7sEM3z3qR132AOdrSYpNnMKBv3Dd/jFyTspA46I6e9frqBIaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789975762; c=relaxed/simple;
	bh=xzXXEOvBKADIqYgT308UZ2eSBS3a+ZXoBUY1e0z1Th0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lMEiMwPZE1sg1sKhdaV4IunfzL/LlXvbBy4XkB0cMmn/S3wkN5KP40KMUsEtWdbX8R62fjyAHEPUOy36lrI3nTE8OQMkqzHYXAIeHfXP9uCX+AuFqed+dbu+1UGqN2UVOyONXvNQFrKOWVrjN7gEBYCOnhf0EPsaWRKosrg2qKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dnrEs2ot; arc=fail smtp.client-ip=40.93.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dnrEs2ot"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCjq5IXoS2PQyCf4FvY768Rbnq/pJoozLi/ACsie/7fd66Neq6Yk1MVgyGzhGeai6NicuiahUE+7JoGUHfWSc4OIjJGSnKyv1oGF8QcusSW3fcmPFXWkJLQEXyIu0U/yb/S9slHvMl3Wf3cTUssRfR2HVGjmu1fMW36ChACj9e5aFv5vyi5Y+enh2j4lFdngJKK6kl9solb8BMs/g6a2Ker4qFZUWdiEUhX88MBZe8Xuy0g8obnCPMtBxhlI4qXW04YW7KE+jvIMtYo+JtLJ5vjjAtMbPp3rmg2iHvcm73XvmPb1tk2xETbYKqPEUBu6B/s/RWUM2ig7oVrsGMSOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gb6UYdaV5ujDirAD4qUa/TmbZnJn0g/wALO8BU32t04=;
 b=k31OIwZcBdy6JPiF670WieFy9J7KEm1qGDSzdBpLLqgej+584ubxXy+AR3puNOTQeCutgYJ9l8RBE+Mp31iPSOapgbl2LUpLtP9FzZznFuIxtr2HX2xLaSv+ScThizJN/hKfUnMMUYpNTJCpfZMOntBW8z4sIZj3raU7BYwqYLYP1zExR+MQIcUG1kdralLbD6mbNLLdt50bm3bb8m3DgVBocHzCzkSnMdvPwn77DFDDdmYTaNITUDrXWLXyDlJVj2YJY3CBKkin9osfj4oZn0Z8F9QRn8MZ0cW7c0+oLQLSwJkFXbGWm4RGyf67tPOaWLAoJPQYePtcIpOX64Cv3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gb6UYdaV5ujDirAD4qUa/TmbZnJn0g/wALO8BU32t04=;
 b=dnrEs2otwe3z/DKQhaipEEBP38gm4lxVkgGtnWWCDE/FguqFLrR44tMBZdUZ0M/rU4CfPdyaZT28GjncgBghQgs8zzFG8Np2/Y8LsNH1sqIdHHIGaLlSmcuhBQ/ChhInIgfQPQCZJ4MwoUwUyHIf5VXBFXQbyKZOIW95Qv2D8TfB++BuCMDDRmccKFEomRPeajlPWr9Pe445fTQ5eJRvXsKuKSpPGlI18CXAYshQqAD3rat55XFSnDIMuP0HtAWod2ZEeX6BnDd7Rv7iAM0f9AnGsNo5muTI+FCX9GWg3L773uXCmZjzY9nCGT5Pi3AocKZegWsJNEwoFtj7Jou24A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:29:11 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0428.014; Mon, 21 Sep 2026
 07:29:10 +0000
Date: Mon, 21 Sep 2026 15:29:03 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Gaobin Huang <huanggaobin23@semi.ac.cn>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>, linux-kernel@vger.kernel.org, 
	Anisa Su <anisa.su887@gmail.com>
Subject: Re: [PATCH v2] cxl/mbox: bound the Get Supported Logs entry count by
 the payload
Message-ID: <arDU-kTVCa4z8C8l@MWDK4CY14F>
References: <20260917104603.2658529-1-huanggaobin23@semi.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917104603.2658529-1-huanggaobin23@semi.ac.cn>
X-ClientProxiedBy: TPYP295CA0032.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8efea5-590a-4244-610c-08df17b206b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|56012099006|3023799007|11063799006|5023799004|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dkOe979zAvRVYla3n0ygW8fVZPqjwGPo4qe/cWoeYB5UrjpLxZ9pnzb7OzL/ScGiF82NhUcrFNVs/ekAn+uv4nDR3SwaE1BOo7l6DgqKLhkZQGz82HSfrg7wjxHHmQUdfG9Zpgl5hH8n2XJlidXalqC42WsU1XK998bb6dndezbysXhZEIUuoNnW11PAO0FAsPPBUKWQ2EkixoIe5ydSMyUmbHCG2LAdCNa6hDUJhv84+1bT/5EW/Uek3cmk0q4Rplaoh43ky00FCbxdyWZeNxWFDeZU24N43d0vZC3CLTRTmBpT56Bl9Y0IhyZ+fqVw6rDrnFE8SaudP0S6H5dRq4lXK1zFGF7ITws3vxoONruo7nHzOVSzN70nAphMJwJAZGfklzfHV3HOp51lFaE6d/lYfzGjVzIKRwtdrdk/xUVLmLPUB5He5z5bcGFeUOIYzHXK7Z/ZsJdnNtKBdNwn9U3EB5A2QUSiI930uvrH+3n+iZXGxo3ETfcsdO3IKeoypbVktvIA0QZ2Lu5Kk9VTWksykctJ3+vSu6QeNR9YWtnSvYlLouBborUP4DfxfTSwn7CsqP729GYXff0Tq/X+uWTpItEvibLSs4/5pyMC9hshWoJ5+gWB/FDG3THIOSbCDu86+U+kG28Xxr/2sBjtEkKHKdHwkcqrwU4Rkzg/LA8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(56012099006)(3023799007)(11063799006)(5023799004)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hncahagcPQGBqt2hCqd6NBndyWbsuJGVWedD7Zab7FHxwyHWU91yRzUBaXki?=
 =?us-ascii?Q?+xYHSH8t+a9Tsm0ldqkHBZEhCHHdWtzfLRTxISnVsk+FRKpE9J7drbBR3Vl0?=
 =?us-ascii?Q?XywNChnOQCK5AbwlWimW2I+5zZxEJeCgCAO4I1JYXM0365Y1xEWKPzzGcom5?=
 =?us-ascii?Q?24ndMrm4qFBysgLdq+/fc9ogAMwPPCh9Delo9FR4NLHty9p9+VTkgXlYmOma?=
 =?us-ascii?Q?iOsvtMUEujCWG5cqf40ypVJM1C7vCNIfFevKGMniuiW9q5TC9iaawx9RhJTf?=
 =?us-ascii?Q?LBiqbe9CmQxK4TMhpSmVQK6FBM8ZqPz6sR88hE8UjSTF4lzUHObtnhm3+BY7?=
 =?us-ascii?Q?YJWPLuXtFDQubRGr6MhG3AmiDWwvUhPMcrCli/uY0kfueXc0xJgvCu2Q4z7i?=
 =?us-ascii?Q?01Ucd921GPPMLHbOZy1zvpSjjbli5YacRh8Toy0cTAkRX5vfdtU751wLnF01?=
 =?us-ascii?Q?Ssze6++sUrss58qcWYRIevgCidG9HDtDA9VlqUzP/eKisBDjRYbInW4Yt6lQ?=
 =?us-ascii?Q?dk0kgQLY555L8VtzbHsflE4xz1ZpLG2rqzgx37l4oAkAObC64PFPip5WT0Dw?=
 =?us-ascii?Q?/vw993TE+sQL41iwp03gHdI9CUIdVDPxV4qKwqvYBgOgEfzzKp23wmfQ6PWo?=
 =?us-ascii?Q?Gl8CR+CHdsfazN+35oazDheoI/9hnT3uUbyiviuvI9tYpJ1zBn5MGaSUDqad?=
 =?us-ascii?Q?AMlwa7JkLXeQ8qqj0MJis8rF2TRVSfLP47xlSLZ4ae8oPIOvSn7wmcEO2O2d?=
 =?us-ascii?Q?bqduARlv6sdemDtjijvQXreN4xb5iOoTOfkJC8TtppBkj7j2LwvMns2L76Cc?=
 =?us-ascii?Q?tZMa0p9B37PBQw5Rkqieg1mkx0I/zYr5fSELmI7ZI3/C84Ex35mhtAKr8FUS?=
 =?us-ascii?Q?Uv4d9ZZwtkQAlmxIx0DgdzNs0fkrnBWHOLBavTLfsOOrDGPer5ZaezIxVlv2?=
 =?us-ascii?Q?1PJ/emgrmu3680xVCCgjtCq/OKvcYFAEJdp+5Ajtz025gUb0uEPL8PGWiGyn?=
 =?us-ascii?Q?sDdfPb2EGA9mcfodBUBhtJOmhuhMQrUU8cbTZbl0hF/HjIQ+nJrlRBypC3Ph?=
 =?us-ascii?Q?5XnT8AemEAfROWm029VtfbV4TjNJb/kduorr79rOgY7OVm5wiBPt1c2dZuPY?=
 =?us-ascii?Q?r0BoPMsLutkWRw6SVw1TF14h1M1RVRKzfF/DZKGL7TVubZybbhwHp6qH7Wsk?=
 =?us-ascii?Q?oTYEjGLgGPxBQ8vuFsJgH4bZD3B9EQ8VLUGmZLBamFIjb7fDNAcTnngXytq9?=
 =?us-ascii?Q?vNVsQOqykjNjPHQH6YxnZwQ0IEwKuaeU7NLPjtVNSOeGUWJTU6Q9evxSF9V6?=
 =?us-ascii?Q?qKQ34IjAt6ddDyLwqMi4hfHERped9Tjbpe4HL0cWFHj8UKaPKZMxFB26SCX8?=
 =?us-ascii?Q?zEYYPzpJmMYmpFm9Wi8GXL/pjoqKr/5uIyc049s0y9jIcvJZaiEL8M/i7ZPn?=
 =?us-ascii?Q?gXMCbFB6ts8cFIB61wfQtzirCcQhkBJqyKHlZORQdB9y97A3pS6UHEMb7wdt?=
 =?us-ascii?Q?eiyW4758Vk2zoJD0HID4RcGLpQ7CHrk3gg8w94pW2HAJBXkms2H95vOkEId6?=
 =?us-ascii?Q?aNqyLWoop9qWt7Fkf/7zBOheH+m7wn/eDK8Z8O33l5Q3HjSsA9HYOGC+Ab9T?=
 =?us-ascii?Q?vgLUjKoankW/r+g7wwmKwbOr/tqybdg7TyX+cJMBDXsmx3QQNb+cXMAGVoK6?=
 =?us-ascii?Q?vRh+xwbdQ4Uxh2JDjw+5PNAW+nO6rzeIWfonWlg0vhp5U30NvdTZjbrISzbj?=
 =?us-ascii?Q?AQv1XeEsWg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8efea5-590a-4244-610c-08df17b206b4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:29:09.9101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odmPtUnW2eInVCIQwJx/ZcAG0EOPX2hWxTxkOOsvrkBuVKKADZ+fPRPF8m/2RrJYbmBG1q1ZaYZZQlEjpcIOvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949

On Thu, Sep 17, 2026 at 06:46:03PM +0800, Gaobin Huang wrote:
> cxl_enumerate_cmds() iterates gsl->entries entries of gsl->entry[] using
> the count the device put in the Get Supported Logs response.  The response
> is only checked with .min_out = 2, so a device may report more entries
> than it delivered and the driver reads past the end of the buffer.  This
> is probe time, so it happens on every boot of a machine with such a
> device, without any host action.
> 
> cxl_get_gsl() can already tell the caller how much arrived, because
> __cxl_pci_mbox_send_cmd() records the copied byte count in
> mbox_cmd.size_out.  Derive the number of entries that fit from it and stop
> the loop there.
> Guard the subtraction too: min_out is smaller than the response header, so
> a two byte response would otherwise wrap the size_t arithmetic and leave
> the bound with nothing to do.
> 
> Like 1/2, this is hardening against a device that does not honour the
> protocol rather than a fix for a regression: an honest device never reports
> more entries than it returned, so no existing hardware is affected.
>

Hi Gaobin,

I have some comments and issue, maybe they can help.
 
> Reproduced on the tree this series is based on with a QEMU Type-3 device
> that reports 0xffff entries while writing one.  The 2048 byte buffer holds
> 102 entries, so a claim of 102 is still inside it and 103 is not:
> 
> 	BUG: KASAN: slab-out-of-bounds in cxl_enumerate_cmds+0x1e1/0x870
> 	Read of size 4 at addr ffff8880036de810 by task kworker/u8:4/48
> 	 which belongs to the cache kmalloc-2k of size 2048
> 	The buggy address is located 16 bytes to the right of
> 
> The Read of size 4 is gsl->entry[i].size.  With the bound in place the
> same device logs
> 
> 	GSL: device claimed 65535 entries but the payload holds 1
> 
> and enumeration continues with the entries that are present.
> 
> This is the cross-check get_supported_features() already performs in
> drivers/cxl/core/features.c, where a device supplied count is compared
> against the retrieved length before the entries are used.
> 
> Signed-off-by: Gaobin Huang <huanggaobin23@semi.ac.cn>
> ---
> v1 -> v2.
> 
> 1/2 of the v1 series (the event record count and cxl_clear_event_record) is
> dropped.  Anisa Su posted a fix for the same bug in the same function on
> 2026-08-31:
> 
>   [PATCH v2 2/4] cxl/events: Validate the record count reported by the device
>   https://lore.kernel.org/linux-cxl/20260901002912.958-3-anisa.su@samsung.com/
> 
> It bounds the count with the same expression (struct_size() against
> mbox_cmd.size_out) and carries the same Fixes: commit (6ebe28f9ec72), so this
> is a duplicate, and hers is the better of the two: it fails the command rather
> than clamping, which also bounds the per-log loop.  Clamping leaves nr_rec
> non-zero, so `} while (nr_rec);` keeps issuing Get and Clear Event Records to a
> device that never clears them -- a hang, which is worse than the read it fixes.
> No reason to post both.
> 
> The patch kept here (formerly 2/2) is not in her series: it is the Get
> Supported Logs entry count during command enumeration, a different function and
> a different response.
> 
> Changes from v1 to this patch, from Jonathan Cameron's review:
> - drop the Fixes: tag; this is hardening against a device that does not honour
>   the protocol, not a fix for a regression, and the commit message says so now
>   rather than leaving it to be inferred.
> - use struct_offset(gsl, entry) and name it gsl_hdr_size so it is not read as a
>   pointer to the header.
> - fail the command when the response is shorter than the header instead of
>   deriving a zero bound from the subtraction.  That also removes the ternary
>   and the underflow it was guarding against, so the comment about wrapping went
>   with it.  -EIO because that is what cxl_internal_send_cmd() returns for a
>   payload size mismatch.
> - add the missing blank line before return ret in cxl_get_gsl().
> 
> Anisa Su is on the Cc list, as she asked on the v1 thread.
> 
>  drivers/cxl/core/mbox.c | 39 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 55828a836..e7daa23de 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -794,7 +794,8 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  	set_features_cap(cxl_mbox, ro_cmds, wr_cmds);
>  }
>  
> -static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds)
> +static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds,
> +						       size_t *len)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_get_supported_logs *ret;
> @@ -818,6 +819,7 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *
>  		return ERR_PTR(rc);
>  	}
>  
> +	*len = mbox_cmd.size_out;	/* bytes actually received */
>

I would suggest to keep the signature and do the check here instead.
cxl_get_gsl() issues the command, owns the buffer and already has the kvfree()/
ERR_PTR error path. Then the caller doesn't need to know the header size or
the entry size, and gsl->entries can be trusted by whoever uses the struct.

.min_out = 2 is the only min_out in the tree that's not a full header.
Raising it to struct_size(ret, etnry, 0) lets cxl_internal_send_cmd() reject
the short response with -EIO, so the "too short for the header" part can
go away.


>  	return ret;
>  }
> @@ -849,18 +851,47 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  	struct cxl_mbox_get_supported_logs *gsl;
>  	struct device *dev = mds->cxlds.dev;
>  	struct cxl_mem_command *cmd;
> +	size_t gsl_len, gsl_hdr_size, max_entries;
>  	int i, rc;
>  
> -	gsl = cxl_get_gsl(mds);
> +	gsl = cxl_get_gsl(mds, &gsl_len);
>  	if (IS_ERR(gsl))
>  		return PTR_ERR(gsl);
>  
> +	/*
> +	 * The device chooses the reported payload length and min_out only
> +	 * requires the entry count field on its own (2 bytes), so a response
> +	 * shorter than the header is reachable.  There is nothing to enumerate
> +	 * in that case: fail rather than derive a bound from an underflowed
> +	 * subtraction.
> +	 */
> +	gsl_hdr_size = struct_offset(gsl, entry);
> +	if (gsl_len < gsl_hdr_size) {
> +		dev_err(dev,
> +		"GSL: response of %zu bytes is too short for the header\n",
> +		gsl_len);
> +		return -EIO;
> +	}
> +

The only kvfree() is at "out" section, directly return here would leak
gsl.

> +	max_entries = (gsl_len - gsl_hdr_size) / sizeof(gsl->entry[0]);
> +
>  	rc = -ENOENT;
>  	for (i = 0; i < le16_to_cpu(gsl->entries); i++) {
> -		u32 size = le32_to_cpu(gsl->entry[i].size);
> -		uuid_t uuid = gsl->entry[i].uuid;
> +		u32 size;
> +		uuid_t uuid;
>  		u8 *log;
>  
> +		if (i >= max_entries) {
> +			dev_warn_ratelimited(dev,
> +					     "GSL: device claimed %u entries but the payload holds %zu\n",
> +					     le16_to_cpu(gsl->entries),
> +					     max_entries);
> +			break;
> +		}
> +

Agree with Alison and Jonathan, don't clamp here.
CXL r4.0 Section 8.2.10.5.1 Get Supported Logs, Table 8-249 Get Supported Logs
Output Payload, defines "Number of Supported Logs Entries" as "the number of
Supported Log Entries returned in the output payload".
It's not total, so a counter larger than what arrived is a malformed response,
not a partial list.

About -EIO v.s. -ENXIO, I would go with -EIO.
cxl_internal_send_cmd() documents -EIO as "Unexpacted output size",
-ENXIO as "device reported an error", and this is a size mismatch so I think
the former suits better.

Best regards,
Richard Cheng.

> +		size = le32_to_cpu(gsl->entry[i].size);
> +		uuid = gsl->entry[i].uuid;
> +
>  		dev_dbg(dev, "Found LOG type %pU of size %d", &uuid, size);
>  
>  		if (!uuid_equal(&uuid, &log_uuid[CEL_UUID]))
> 
> base-commit: 999811aca000b0d3d1c838c60dc9db7c72eb0c73
> -- 
> 2.34.1
> 
