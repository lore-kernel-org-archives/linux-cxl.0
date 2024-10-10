Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302021C9ECE
	for <linux-cxl@vger.kernel.org>; Thu, 10 Oct 2024 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568052; cv=none; b=NcrcstMT4KYQNx3tY+wmOh5S8jPspE6MfBCvsCsrDmZJBlKdq9FM9BN+cCm0MbSvOQr2B2LkXf6Z10TXbPEwI2D1EDMVpnqM8mEq2STNkHjT1PL8GvndQhC4KfW3Nq7HyeMVvfLjuYsLNKxpeG/R/yECuDIAPndFRLAx7TFdL0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568052; c=relaxed/simple;
	bh=MrEhm0OtyQrbVJzG6ipSNS9SAbMoJNzexjfEfx4WFnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mc5O41PgAtg5Bhgse4cs0wNtGmOpVFPTQy+sToAS1xLh1Wk345s+xM9YCn6KGyl30/I+s8aMuIvVyzrsSIUqYaqPhi+0p5ucXp1Oron3Qg4jXiZzwBFu+tjcfybu2qFjMejvGlSFPJr+PYc0V3vlXJXtPO0LmLET+AIynenKa1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=RZWkP8r5; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="RZWkP8r5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1728568050;
	bh=SNtGl0htC2wcy3umrpu79n9cwuSf8KzJj9a6iqMHrBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=RZWkP8r53ZCnnMgikAE/VeCbZDoKGO6kAFxYVc31/CVsomMhiAEm+tcyyk2TRxMWm
	 eZRuxl/IXKcOPMNQ6vI6ntIStc4B7W8TEL/I7830Fr0l9s+AOUQ6m2AJcfL5ZPpLoS
	 qRV8abPhM7xvBNdGeFc2qEmjfXlBdPTRYdlod3ctoe4zHMM4zUctpSrfQASEHaxIMe
	 ZsOa6ObWu7W5vPGSuIN1eitXuQ9sw2XQUYlHjxDcf6nwIJq6IrqKjc5XKShJa7gJCY
	 2qJ64poF/gKjE+sTIRPd32mxl1h8IdMLVkNI/3S089bP09/9JheCyLx7BFGF5m9VdI
	 HoiLDbQya1kzw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 977ECA0318;
	Thu, 10 Oct 2024 13:47:24 +0000 (UTC)
Message-ID: <75e2b3a5-e8ed-47f2-8f7d-89c6f9481026@icloud.com>
Date: Thu, 10 Oct 2024 21:47:21 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cxl/region: Find free cxl decoder by
 device_for_each_child()
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_zijuhu <quic_zijuhu@quicinc.com>
References: <20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com>
 <20240905-const_dfc_prepare-v4-1-4180e1d5a244@quicinc.com>
 <2024090531-mustang-scheming-3066@gregkh>
 <66df52d15129a_2cba232943d@iweiny-mobl.notmuch>
 <66df9692e324d_ae21294ad@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <a6dae308-ff34-4479-a638-8c12ff2e8d32@quicinc.com>
 <66dfc7d4f11a3_32646294f7@dwillia2-xfh.jf.intel.com.notmuch>
 <e7e6ea66-bcfe-4af4-9f82-ae39fef1a976@icloud.com>
 <66e06d66ca21b_3264629448@dwillia2-xfh.jf.intel.com.notmuch>
 <66e08f9beb6a2_326462945d@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <66e08f9beb6a2_326462945d@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: p4NiH2jssWHjSxaPAhKl2mS26oD5TdUd
X-Proofpoint-GUID: p4NiH2jssWHjSxaPAhKl2mS26oD5TdUd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_11,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410100092

On 2024/9/11 02:27, Dan Williams wrote:
> Dan Williams wrote:
> [..]
>> So, while regionB would be the next decoder to allocate after regionC is
>> torn down, it is not a free decoder while decoderC and regionC have not been
>> reclaimed.
> 
> The "simple" conversion is bug compatible with the current
> implementation, but here's a path to both constify the
> device_find_child() argument, *and* prevent unwanted allocations by
> allocating decoders precisely by id.  Something like this, it passes a
> quick unit test run:
> 

I submitted changes suggested by Dan as shown by below link:
https://patchwork.kernel.org/project/cxl/patch/20240917-const_dfc_prepare-v5-1-0e20f673ee0c@quicinc.com/

I also made a little modification based on that Dan suggested.
welcome to code review again (^^).

Sorry for this noise (^^).

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1d5007e3795a..749a281819b4 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1750,7 +1750,8 @@ static int cxl_decoder_init(struct cxl_port *port, struct cxl_decoder *cxld)
>  	struct device *dev;
>  	int rc;
>  
[snip]
