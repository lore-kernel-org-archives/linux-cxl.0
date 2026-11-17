Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884428;
	b=nj4U3yshavULCL9KqWv+p5dRQSb6vXn38OMLSIXSFFiyVVy8WVTNeKYUScs/xXcYnQ1g
	 YFMRK85BXjbiiKZfEKUpkPDCLpNVF2hVFgACPpI1X4iZscacuZLLbgholjABDlOg2WOcz
	 JpH7g5Hw6DZ/U8M9dOROabvCvZC8v/91Ugd4jeoUe3rGHY3t/A955HIlwO2DT0EQNaUvt
	 XIQIUXRp7SlocIf+LU4gz6dDeyWYiYbCVUljY1hbzatLyntJ7P/UPpbhJ4ElDHr12zPNf
	 nUzqAwwiMUZX+H1GVkQsxNoKmXA3Sad1ZiTjJo0x+a5nWXjEUUpv10Jb0RGRI87p9MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884428;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pxoBSMsRqRAfxvCgosYriPsm/EIyLsxkC0pfqHHdRVg=;
	b=at08iDdrIBhV9MCx8bv72EHEzxdTsBrI1gjN0Ex3n2pR4j2fH/nPLnUQJrEDaz+uQhKs
	 DupSPURDYjTHpbVucSEX42aVuwIFero/AkPnlJzjzGn2sG6I78ZBYv0xmqniYJDcCTEfr
	 msC0aZNfJZVZtLEG3qVKb55a4X42X6PlpvTx8WmsmwGvwYWn+5aY1nc7KM1bKSe1Qcv10
	 92MZj0OmdleW7H29cK27dYq52Z4TzhPLlrsoz7MWotJxVFdlKQN9JW2PjxPljwcVr59Lb
	 mO5phkNsxFA1q90TC/cnLV3ZXrIdUs5sd/fYq8c5WfGlbtgjvSieREKZJUZpJAYjqDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=muUJqIr5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FnYZ62gb;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C01606A330
	for <linux-cxl@vger.kernel.org>; Tue, 17 Nov 2026 03:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16C01606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=muUJqIr5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FnYZ62gb
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH2aExs4146663
	for <linux-cxl@vger.kernel.org>; Tue, 17 Nov 2026 03:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pxoBSMsRqRAfxvCgosYriPsm/EIyLsxkC0pfqHHdRVg=; b=muUJqIr5E5bpiDnl
	fPKEs1M3qJ1AKWljp/NRaz8kWxlIpSs1ly4uZFVTb5xPYNTDRIsisFTUrq3B+buh
	bhNk2YbazmXHMXOusolSEHbVzv52VxoKnjLytBZ6L+BRGX3Nnkd387oqVFl+Ocqw
	Nmw4m8O65wrkYakIXcljI7aeZ6czygqV3JjH8z91EuPVcmWiK1ReRFuo0sK7sehF
	h2GwPQqkX8zzSFcQXXu9iah4sHv97Vix56fFgnvhzmSDkKIcfOU+MOPARRCQacRO
	XJaRT0widME0MVAP1ttfsaOXSTBsOb7E3jaMlam0HJzMG8t/dnXToO0tJT6wvoqU
	RGWE9Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j00nfke9h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Tue, 17 Nov 2026 03:00:26 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad30487d55so3142658a91.2
        for <linux-cxl@vger.kernel.org>; Mon, 16 Nov 2026 19:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794884426; x=1795489226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pxoBSMsRqRAfxvCgosYriPsm/EIyLsxkC0pfqHHdRVg=;
        b=FnYZ62gbj0SOMEEsAvGzBsLRcwWdiJHCIRuxG51u3+OVcQ6f5mEn2AipGImCv9drE0
         /S6r9nisLbttiiWtROsaiEdMmFIRarcEJku7q4f0mNGS1xE/9nc65qX1M7euWB5Be+Ma
         fwrEqFICZg0ko3kZ/qrWJZBy+O/wYFsOiSHuMDqgXwobgc2Gbi6WlPT6/OXzSdRYxaPb
         YwX7R4a4eOh8RLcldLhj1cnywz2HoNH3Gefen6UjpfgT2UepXpa2a0MoVHcuYx317tZe
         3RzXBbsUdfZPGPGPcJxcJOsCebc538Xl1SsJvfchE3EI1iCUSIKqG2xUCtG0IarWNVz3
         0ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794884426; x=1795489226;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pxoBSMsRqRAfxvCgosYriPsm/EIyLsxkC0pfqHHdRVg=;
        b=RM5k+ArgK8Bdz10CWc63HLHcrZ+3nuzxYI5Ms3aVJh4Xm4snwoRMQo4ULPG+H01OGw
         CIUGK2RJEv+AdO7OaXAABXDMWje/F1snE2S6clVOJuw4DIfk4ut++4/blwksNarhKeAD
         VRJ9q3aAv7AhktbucecWWRbvQqGHfjUzTYXkeoE1eu2mYbdvwKBBp1fhr6RmnHUWhlww
         Wy8n9A1iQh+hx6P+qRCbBFi9MadD9kmLniEyaev1jpjnr2FSzPshCkQy92jbRfx8GnEW
         4XOqEEADiUojGQwfSelfp66EAUiYHCV/e/PfJr4mEX349P+wmoH/ukY+OWID45EkLWsw
         3shQ==
X-Gm-Message-State: APuU4Z9wj6ZpTUP/M1KJM53eZ9kUP/Zg2n+mzLsZf0dSk4tlVEexAP4L
	C/jlqBTEYEpMHkK6ir1HRw8LUph4du3XYBqqEPx+nK/3sX3YFcTqGRdY+AnsHsMfEV2noOSprGZ
	oN6AybAfFdlIE69qY2ZerhGD/LTMZS2XiEgCj7GSIjDeU6SsA0HSyFI/A60JYwlg=
X-Gm-Gg: AZFdTZdYeGryROl9tHZ/qTd/mHU0I/d9X41+wDJ76NayViz/XtrFxx3jrI7yyWreWCK
	KlWf3Uomptv5dY+F7O/h8WCK891OXM+UAn2t52AtN869hQd0aLVbU53zXmqUCOFsnDwvpr39ALu
	wevF5hE7UzDcW8WprFbFlxEUJEUca7DZJUwZqGxAxoTEGPeUo7OpwXlDu9m5Iuprkil3KUhDn5/
	kpTqNT3N25BJhRI4PTbbfVtH24A9Vvhmdrtg8RiLpmOWywXzi1DP5anYmMQP4IawnX1J2xyujVF
	dq0ziGixlV0unIwQ6uUSZMns1NhjNnCxNDMoCoZVtqU5QweyuBYIuYISXyITA2/HDgxdpoySLWI
	KYIIOdJnT+phn6OqsQJUx4QZcxRJb7QfAsEN053JM8YTGPocUQNj0rRoargaLsyF80Ps=
X-Received: by 2002:a17:90b:1b01:b0:3ab:2d46:1dd2 with SMTP id 98e67ed59e1d1-3b1b08798bcmr12415261a91.6.1794884425494;
        Mon, 16 Nov 2026 19:00:25 -0800 (PST)
X-Received: by 2002:a17:90b:1b01:b0:3ab:2d46:1dd2 with SMTP id 98e67ed59e1d1-3b1b08798bcmr12415197a91.6.1794884424516;
        Mon, 16 Nov 2026 19:00:24 -0800 (PST)
Received: from jic23-hlaptop ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3abeaf532sm1595030a91.14.2026.11.16.19.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 19:00:23 -0800 (PST)
Date: Tue, 17 Nov 2026 03:00:14 +0000
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Alison
 Schofield <alison.schofield@intel.com>,
        Davidlohr Bueso
 <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>,
        Vishal Verma
 <vishal.l.verma@intel.com>, Fan Ni <nifan.cxl@gmail.com>,
        Li Ming
 <ming.li@zohomail.com>,
        Benjamin Cheatham <benjamin.cheatham@amd.com>,
        Gregory Price <gourry@gourry.net>, Richard Cheng <icheng@nvidia.com>,
        Anisa
 Su <anisa.su@samsung.com>
Subject: Re: [PATCH v1 05/14] cxl/mem: Add 20 second timeout for stalled DC
 event chains
Message-ID: <20261117030014.6676dd47@jic23-hlaptop>
In-Reply-To: <20261104230445.66625-6-anisa.su@samsung.com>
References: <20261104230445.66625-1-anisa.su@samsung.com>
	<20261104230445.66625-6-anisa.su@samsung.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BrEIUoX5 c=1 sm=1 tr=0 ts=6afbc34a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=hD80L64hAAAA:8 a=rNSifS95Xc4NCOkr_3UA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAxMSBTYWx0ZWRfX6moCT2lzmjO9
 J5j/XJB1+fUmExRO29IfDbVfdp5kjcCkev5OElin33ldyfD2krIx8DQG1cgXKUwOaG3RURx+B9O
 osFScFG/yadA46u8oJ1J1jV6eQORqVk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAxMSBTYWx0ZWRfX1tgcNDsIs9Ap
 d+LjGAh9ocImmJdbpqjLLnAgiG+KjBRbsh16L2Veb4ik/TFovpnijIZbuGwAMHh6ZtGMYutRqLI
 MHff7Sxv/zeTBnmfW5O0IEMC/BxMRrBjDJqQdflKwhPqCCabXuocV/RiNecrA9qMWxswEzRSfmm
 CW2vfBiLgFU66kpGhm/dzd6Lh/+d9lzpJGdTpVR4Y52+4Vxpcf0Xz9L93psolHiXgIlYIVxZ1f9
 Sez+J/aq2nCYNC79mTgSbDNmQe9SZp1rvsFkLZY28YELv7LeQkQCzJ1g0m9241vrfBceAGYjQhc
 UlovpNjVUQmXdKwZ161w5sAoyuWufFe2tsJUppXFAcuzKs+Tc0+PCSsKFnFE2UT+z9RiDGmkehm
 +ilpHt8Uy6bq2M1eAz09J+QWrODfAF0insRM5Wa2//eAITH097wPhaUU/cOvKnaNBMhhlkN3+p/
 pevrKrQszI93IfQXjPQ==
X-Proofpoint-ORIG-GUID: ZaavgiEnBoLJP6yqMoz1DAGoKjdb-cnb
X-Proofpoint-GUID: ZaavgiEnBoLJP6yqMoz1DAGoKjdb-cnb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170011

On Thu,  5 Nov 2026 08:02:29 +0900
Anisa Su <anisa.su887@gmail.com> wrote:

> A Dynamic Capacity event can span multiple event records grouped
> together by the CXL_DCD_EVENT_MORE flag. Extents are staged in the
> pending list until the last event record ('More'=0) is received, at
> which point the chain is processed. If the device opens such a chain
> (More=1) but never sends the closing record, the staged list sits
> indefinitely.
> 
> Add a delayed-work watchdog that drops the chain on timeout: an add
> chain is refused with an empty Add Dynamic Capacity Response (4802h),
> a release chain is left for the device to retry.
> 
> The spec sets no limit; 20s is a generous upper bound that may be
> tightened later, and guards against a lost mailbox response or a
> crashed fabric manager.

My gut feeling on this is don't paper over it. 
I think there should be a standard recovery flow from crashed fabric
manager and today we may have a hole here that needs closing. That
might be as simple as a zero length dcd extent sent with the more
flag not set to terminate any sequences in flight.

Lost mailbox responses should only happen if something worse
went on so I'd expect some other ras indication.

Anyhow, I'd suggest asking your spec folk to raise this (or poking John
Groves)..

> 
> The deadline is fixed when the chain opens rather than extended per
> record, so a device cannot keep a chain alive, and the staged list
> growing, by streaming More=1 records.
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> ---
>  drivers/cxl/core/mbox.c | 84 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 15 ++++++++
>  2 files changed, 99 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 3acf5ace48db..fea910e6c510 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -873,6 +873,8 @@ static const uuid_t log_uuid[] = {
>  	[VENDOR_DEBUG_UUID] = DEFINE_CXL_VENDOR_DEBUG_UUID,
>  };
>  
> +static void cxl_cancel_dcd_chain_work(void *_mds);
> +
>  /**
>   * cxl_enumerate_cmds() - Enumerate commands for a device.
>   * @mds: The driver data for the operation
> @@ -891,6 +893,16 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  	struct cxl_mem_command *cmd;
>  	int i, rc;
>  
> +	/*
> +	 * The DC chain watchdog sends a mailbox command when it fires.  Register
> +	 * its cancellation here, once the mailbox is usable, so devm runs it
> +	 * before the mailbox goes away: in cxl_pci the device registers were
> +	 * mapped before this point and are unmapped after the cancel.
> +	 */
> +	rc = devm_add_action_or_reset(dev, cxl_cancel_dcd_chain_work, mds);
> +	if (rc)
> +		return rc;
> +
>  	gsl = cxl_get_gsl(mds);
>  	if (IS_ERR(gsl))
>  		return PTR_ERR(gsl);
> @@ -1198,6 +1210,14 @@ static void clear_pending_extents(void *_mds)
>  		delete_extent_node(pos);
>  }
>  
> +/*
> + * Bound on how long the host will wait for a device to finish a
> + * multi-record DC event chain (More=1 ... More=0) before refusing the
> + * chain.  The spec sets no limit; 20s is a generous upper bound, the
> + * maximum GPF timeout.
> + */
> +#define CXL_DC_CHAIN_TIMEOUT	(20 * HZ)
> +
>  static const char *cxl_dcd_evt_type_str(u8 type)
>  {
>  	switch (type) {
> @@ -1226,6 +1246,11 @@ static void cxl_dc_chain_abort(struct cxl_memdev_state *mds)
>  	struct cxl_dc_event_chain *chain = &mds->dc_chain;
>  	struct device *dev = mds->cxlds.dev;
>  
> +	lockdep_assert_held(&chain->lock);
> +
> +	chain->armed = false;
> +	cancel_delayed_work(&chain->timeout_work);
> +
>  	if (chain->event_type == DCD_ADD_CAPACITY &&
>  	    cxl_send_dc_response(mds, CXL_MBOX_OP_ADD_DC_RESPONSE,
>  				 &chain->pending_extents, 0))
> @@ -1234,6 +1259,43 @@ static void cxl_dc_chain_abort(struct cxl_memdev_state *mds)
>  	clear_pending_extents(mds);
>  }
>  
> +static void cxl_dc_chain_timeout(struct work_struct *work)
> +{
> +	struct cxl_dc_event_chain *chain = container_of(to_delayed_work(work),
> +							struct cxl_dc_event_chain,
> +							timeout_work);
> +	struct cxl_memdev_state *mds = container_of(chain,
> +						    struct cxl_memdev_state,
> +						    dc_chain);
> +	struct device *dev = mds->cxlds.dev;
> +
> +	guard(mutex)(&chain->lock);
> +
> +	/*
> +	 * handle_dcd_chain_event() cancels this work non-synchronously (a sync
> +	 * cancel would deadlock on @chain->lock, which the chain-close path
> +	 * holds), so a callback that already started running can reach here
> +	 * after its chain has moved on.  Abort only if a chain is still armed
> +	 * AND the timer has not been re-armed since this expiry fired: a new
> +	 * chain's queue_delayed_work() makes delayed_work_pending() true,
> +	 * meaning this expiry belongs to a superseded deadline and must not
> +	 * abort the current chain.
> +	 */
> +	if (!chain->armed || delayed_work_pending(&chain->timeout_work))
> +		return;
> +
> +	dev_warn(dev, "DC %s chain timed out\n",
> +		 cxl_dcd_evt_type_str(chain->event_type));
> +	cxl_dc_chain_abort(mds);
> +}
> +
> +static void cxl_cancel_dcd_chain_work(void *_mds)
> +{
> +	struct cxl_memdev_state *mds = _mds;
> +
> +	cancel_delayed_work_sync(&mds->dc_chain.timeout_work);
> +}
> +
>  static int stage_pending_extent(struct list_head *pending,
>  				struct cxl_extent *to_add)
>  {
> @@ -1260,6 +1322,8 @@ static int handle_dcd_chain_event(struct cxl_memdev_state *mds,
>  	struct device *dev = mds->cxlds.dev;
>  	int rc;
>  
> +	guard(mutex)(&chain->lock);
> +
>  	/* Chained records share one event type (CXL r4.0 Table 8-229) */
>  	if (list_empty(&chain->pending_extents)) {
>  		chain->event_type = event->event_type;
> @@ -1279,9 +1343,22 @@ static int handle_dcd_chain_event(struct cxl_memdev_state *mds,
>  
>  	if (event->flags & CXL_DCD_EVENT_MORE) {
>  		dev_dbg(dev, "more bit set; delay processing of extent\n");
> +		/* The deadline is fixed when the chain opens, not per record */
> +		if (!chain->armed) {
> +			queue_delayed_work(system_wq, &chain->timeout_work,
> +					   CXL_DC_CHAIN_TIMEOUT);
> +			chain->armed = true;
> +		}
>  		return 0;
>  	}
>  
> +	/*
> +	 * Chain is closing.  Disarm before flushing so a pending watchdog
> +	 * (queued but blocked on @chain->lock) sees !armed and bails out.
> +	 */
> +	chain->armed = false;
> +	cancel_delayed_work(&chain->timeout_work);
> +
>  	/* Nothing is tracked yet: refuse every add, acknowledge every release */
>  	if (event->event_type == DCD_ADD_CAPACITY)
>  		rc = cxl_send_dc_response(mds, CXL_MBOX_OP_ADD_DC_RESPONSE,
> @@ -2021,7 +2098,14 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>  
>  	mutex_init(&mds->event.log_lock);
>  	INIT_LIST_HEAD(&mds->dc_chain.pending_extents);
> +	mutex_init(&mds->dc_chain.lock);
> +	INIT_DELAYED_WORK(&mds->dc_chain.timeout_work, cxl_dc_chain_timeout);
>  
> +	/*
> +	 * The watchdog cancel is registered later, by cxl_enumerate_cmds(), so
> +	 * devm's reverse-order unwind cancels (and waits for) the watchdog
> +	 * before this list cleanup runs.
> +	 */
>  	rc = devm_add_action_or_reset(dev, clear_pending_extents, mds);
>  	if (rc)
>  		return ERR_PTR(rc);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c88de7cb65d1..52c936ec15a9 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -8,6 +8,8 @@
>  #include <linux/uuid.h>
>  #include <linux/node.h>
>  #include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/workqueue.h>
>  #include <cxl/event.h>
>  #include <cxl/mailbox.h>
>  #include "cxl.h"
> @@ -431,6 +433,11 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>   * struct cxl_dc_event_chain - staged Dynamic Capacity event chain
>   * @pending_extents: extents received so far; flushed when the chain
>   *		     closes (More=0)
> + * @timeout_work: watchdog that fires if a chain is opened with
> + *		  CXL_DCD_EVENT_MORE but the closing record never arrives
> + * @lock: serialises updates to the chain state against the watchdog
> + * @armed: set when a More=1 chain opens; cleared when the chain closes
> + *	   (More=0), is aborted by cxl_dc_chain_abort(), or times out.
>   * @event_type: DCD event type of the open chain (add or release)
>   *
>   * The records of one Dynamic Capacity operation can be chained by the
> @@ -439,9 +446,17 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>   * chain is open at a time.  Both Add Capacity and Release Capacity chains
>   * are staged here, @event_type says which.  Records are staged until
>   * More=0, then the chain is processed and responded to as a whole.
> + *
> + * If a chain is opened (More=1) but the device never sends the closing
> + * record, the staged list would otherwise sit indefinitely.  @timeout_work
> + * is a defensive watchdog that drops such a chain: an add is refused with
> + * an empty response, a release is held for the device to retry.
>   */
>  struct cxl_dc_event_chain {
>  	struct list_head pending_extents;
> +	struct delayed_work timeout_work;
> +	struct mutex lock;	/* chain state, against the watchdog */
> +	bool armed;
>  	u8 event_type;
>  };
>  

