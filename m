Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FE829E0E5
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 01:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770774251; cv=none; b=sauQh41lTYPnTpBwGrEUFj6QlEKATDi0YtxewmvOOQSLgI5Iw9hQqIhSsfXWGchXHdFKom4PJZol6Sr4s7sxmJq/H2WLbiBq6rCTqrGdisLPd1jyYQEF25+7dHfzwZ4FaPbcdP598++5FcunEYXAUzd2212/ps59d5KfhhsTCWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770774251; c=relaxed/simple;
	bh=U2mSstVyceKFcwKaAqTDshpBl2j9PdpZvld1vO9S8HM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0p6gWG0lmH86rNVGEpjv3SGo5O0JGODLUwrKkk2+jI8ME69mBuAQMcU2Nu6fWoIYo8fXE0VRGkCUcCCVS56E0lhn0nHF9IWiFD9EtL6e0JWpIw4H+4GFiYLsKk0Emwe+ZTUFZDZwMqSaPU3BTzUiCSa7TY7jel9fGttA8oZRkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9GIZfrf; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9GIZfrf"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-795176156b1so51590037b3.0
        for <linux-cxl@vger.kernel.org>; Tue, 10 Feb 2026 17:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770774249; x=1771379049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4X6a1TBMUYBFVdnXGoZuljb4hiLr92V6A0PrO+8zJPQ=;
        b=M9GIZfrfmm1kEJFQGD1dLJN8By+WHWvD1+d8RWTfJfoCnqzTdRtjyjUw/Esr9TrL1E
         pSZaWJ404nFEGTyl4sI3odrOpurtqcu6su7DuuSO+ES+5nUnBuW49TR32xDyXmc3sBgs
         zsrT1DOxjJJQLRWFQEhYGHIPnCrZNICcZvt6KNZn+FWkCr9LMHl4YLdrYWI1ii6sJ52+
         qDDbciE+/EmTcPOLugkjR21i4lWlhGL6hnrahnCrfuXXr6PhRsFDE9MFSccFEJi8Y8cm
         lfkKy7lvHy4wd7YFyOrgXVjwwLGU/9Nz9mq7/5vFgMIuEiXVsC4Gtc9+K4hjNKrTm3sV
         G/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770774249; x=1771379049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4X6a1TBMUYBFVdnXGoZuljb4hiLr92V6A0PrO+8zJPQ=;
        b=IjQHeRobbj9VuDGhZo8SBrYRhHi8+s9lZW4wa7n99bSn+xrzoUb6CRPaV6RAz42P4t
         3Y1z7uj1hbZrblRlKZWPFUI8LHzOyKHEMUPBJD8RqasrR7QR/2Cb1AAaz6Kw6jqdjLim
         1gkgriofVMUFLmL89DH+oB3neiohrx/8/vNakU05TcOCUR9PMdj2fnPOamu+Va6EK7Hs
         HEN6OpZgsVUEQirw7uVObYIqvP+iUs87nkYD4iaQor43vxJXEZ1y0S4wx9zM63MYq4G3
         Mp5dy1wBzLFhonBZh1lJCxU7t9zG1ngvUzOfWxFoX9whF7v4gOBIF5179wI6G6h+7Teh
         MnZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGDITHKInSsx0YjSoX0FtEMkWPHmzgW1cir1kNfsIYu+gg0uv0lbCbZxlrIkhi6wV1TNaYOJadSJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyStR5Qv1rGxTrDCx+7KDYXwPuJ7dQnvEFP42wcXUFI8ftoi+Y
	bzm/CqzHg8uUN4fVi03Q0WaGoP55umRne+ra7f2dOGxwaOFahYIrRcuMpp0hXA==
X-Gm-Gg: AZuq6aKl0oiZzJ2kdI+aHnsh2+qJBRZq0B+f7uhJq+bo+WSHLAidYZ1q0kc506gJGot
	XxjU+N2NnARwIdaUpKTGQolrsCOtzh2mDNmzIQGVb2ZnmDVWn2NIl+yXTyBCbLFmZKYXwQMJGxo
	4mZqZScFEpAjfhnHTLscOIwF5e2azsKnTaU8aCYsk/ZTvFWpKhJ46rDFi981+Ejkvf8of1ECeVo
	ullkmmryknalCLyMmlsra1lY6KQ2kJ6jMgcGDlnXJomS3jwP/iRKggntb4Ll3LjPYqraNzvUO/u
	tT1W8wNj3nsHqNP6ITJ/dCLBx/vtYpu8plY1cQt1KaH08d+fc1zyX5YTu9JP0qiZZtt2GeRREpQ
	ckGjLVagNNfpKnndWv8tXY7io0HtX5o/Ll7Iupl4HsxQ+vg2SJ0UaHRW6tKktHwLXSVQIE1wUJo
	TbcKhCbjJ5VAY7SuwwfswYZfgG5/DmzAVBKWh8WuO9xw==
X-Received: by 2002:a05:690c:d92:b0:796:2fde:5dfd with SMTP id 00721157ae682-7966aa83ab9mr9564547b3.44.1770774249211;
        Tue, 10 Feb 2026 17:44:09 -0800 (PST)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c254d1esm3295267b3.41.2026.02.10.17.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 17:44:08 -0800 (PST)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 10 Feb 2026 17:44:06 -0800
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: Anisa Su <anisa.su887@gmail.com>, Ira Weiny <ira.weiny@intel.com>,
	dan.j.williams@intel.com, dave@stgolabs.net,
	linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dongjoo.seo1@samsung.com
Subject: Re: [RFC PATCH 0/3] Add Support for Multiple DC Regions
Message-ID: <aYve5vj6sQ4QjiBa@4470NRD-ASU.ssi.samsung.com>
References: <20251203203540.1091827-1-anisa.su887@gmail.com>
 <6931c4c85a526_43de3100bb@iweiny-mobl.notmuch>
 <aTsyJXKnL0SA1hl-@deb-101020-bm01.eng.stellus.in>
 <693c922448bbc_c04a9100eb@iweiny-mobl.notmuch>
 <aWV0e03pP4hfqkLo@4470NRD-ASU.ssi.samsung.com>
 <20260115102819.00006d55.alireza.sanaee@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115102819.00006d55.alireza.sanaee@huawei.com>

On Thu, Jan 15, 2026 at 10:28:19AM +0000, Alireza Sanaee wrote:
> On Mon, 12 Jan 2026 14:23:55 -0800
> Anisa Su <anisa.su887@gmail.com> wrote:
> 
> Hi Anisa,
> 
[snip] 
> > Sounds good. For RC2, I'll keep it simple and just rebase + bug fixes.
> Thanks Anisa. I was also about to look into the rebasing as well.
Hey sorry for the delay! I've rebased on cxl-next: https://github.com/anisa-su993/anisa-linux-kernel/tree/dcd-v10-2026-02-09

I tested basic add/remove and region/dax device creation with QEMU, but didn't
spend too much time testing as the bug fixes were quite small.

The bug fixes + who they were suggested by are tracked at the end of the commit
message :)

Thanks,
Anisa
