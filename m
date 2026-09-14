Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D67442B2E
	for <linux-cxl@vger.kernel.org>; Mon, 14 Sep 2026 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789414146; cv=none; b=ETpWeSJ9HVHQtOofUgUfuwZYa/BLmNU3RAWhrK+IcZR19sZM59KeKDW1GhtU4qHTPd9gUSlceaDHFAhXJjw3ddOhZmbHfTZCB6WvdfmGpWbozpEqrevimOu/vKbqcwQscW3a7+WraN/3s2kI06bDZj6VqPEYvoM9XiBUJ8c/iXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789414146; c=relaxed/simple;
	bh=FvDuM7JziwITnLEsXhJ9H4B4fIslCSzPltFZXNSoKRI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7MPRymwIPHQdHonixux/wrfDlsRRfWd3UZPiKTWHFq65LUHbfuQy0H/igUdiJXiAK+6IURn45riBUuqa6/VeMWR5N/YNKn0cReFc9PFwRZXRUH6ZlKwNwKjSYp4qHySmmaxq7vPvx43tWtK9LdmBpsghO7xPTQ0r2Itl5BZDtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCRDDRYA; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCRDDRYA"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b350c6920so2225450a91.1
        for <linux-cxl@vger.kernel.org>; Mon, 14 Sep 2026 12:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789414144; x=1790018944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Af6jIKXmT1Z8ylxQIDon0WIhlPoww1uEZeCxYsY+KIE=;
        b=RCRDDRYAwjqAw60151dGjxqSwvb9xLTAfZnUiCJN0zA9vp2iAxz5p7VC68qhIKJyNl
         P3deIcxbMXdrSAVb5nMnWgB+y2dMgBEscbuZb2O4oM7nrH+KJ+Hbe8LiwrBi5I3w/F+H
         ewhoRS775mUmEyvwhbbLxzW/kTUIhrma/cuONaRARCow6MFe+iUbVySriH/2RtpdAuyV
         JWGCDyIPyQvfnNH6hn95Qw+LyahoPVx3ROGwPMJG59/ojweH/TSPJxPMih+GcOb/PWf5
         exFqNIemv22CKASzVB2zy8P60kYsb7/w3f0G/CKK5ntQLVv8MVUjzUkADCGN6i10KhZ9
         JdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789414144; x=1790018944;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Af6jIKXmT1Z8ylxQIDon0WIhlPoww1uEZeCxYsY+KIE=;
        b=V+lcns7wm9/q0RFwcrymPxNPNSBkG8Oyo4Ps49V2rGEnzcgQSNZyuwRWIUjSvmOy9P
         56L5rYy4fXMoCKuaVboyNKF+6Vsij91YtzQkVx6d43YsrRnu9zkXLNDEiHDth251p/iE
         mXMtVkev2q71z3WTwTStizWs3us65f/qVFZyjpajhOfhLWANZ7r7Jeduw7NbsC8RNKca
         5eB+PdCRC0JvJ5KnrSFncOonZNBasaHMlb7iGoV4VJErly6VwR8MK7vKzR0rXPnozUaJ
         z7pd9QEAbCysSemsgcBwlYM8BRYWNmRP9JfhHmvRRWwOt+6yrzd30fw/T8+Zf5lgTLPn
         A57g==
X-Forwarded-Encrypted: i=1; AKwUvBwz7iqeeyAlksjE4wPkLdfagk02FseSeEnRtj5s0dBCT5wnf/qdj81AjzPHubckPJkbVc0S28D8P3I=@vger.kernel.org
X-Gm-Message-State: AFuF++ngfa4lNWPVkX2/ZuHZnksINTAMXaMzPp4bJPpexE5Eb6pqZTPC
	fnSDHB+DPLvGCslwgN7AyqqMqoFXX1vFbzwLuakZX1E+pqQ3T9yxv8QV
X-Gm-Gg: AYBFou0zYnhPj49ZOh8gpcJdK7t/+Ekvizjr6HHLUQ+ogTjYMEMVdxB7/MwaAn+FAph
	9+o2fKDTU/IQaeq5NHuVs5bIgxgkk79NSDLZTPoivl9CwQrxpfe9x9s+AdvZCfIWvcoyqKqKn8p
	zCJ92kxBAtBebOjCJiqypVD5jO6AK1bMPv2GfqYUFyjg3xhO34E21o8o6D65EiFi9q38j0wTbw2
	IqMypmTNTd6gFOzgb+jE954BAiv7f39CR8BXUQhApxNLmSpUoMzyd8JguT2dZhloXYrrTB13jdF
	XfcBcB4rCMkhq/5q7ix1iZD7c8kh96UjSLmtvvZUHjSu76sS5S6LZkstm34UgerZFndJXfKfp83
	MbT1QlDxucAeR9/bTB39DdsPAufQa48DqJBRooZX7N4dlkPbgRn7bjUdrziI2V8aQnTuR9AO+tQ
	FaRftdd1ILeiqaeZMyb1EAyrt0w9cLlJs/0tpb77e6cot8kMYkmwsBrmJB8o6+DS4i9fEQEumEz
	kVPlLUAeX5qKT5E8OgpnLfzKaA=
X-Received: by 2002:a17:90b:1642:b0:398:dc16:3c29 with SMTP id 98e67ed59e1d1-39debf7a8e2mr8009923a91.7.1789414143798;
        Mon, 14 Sep 2026 12:29:03 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdaf5f8dsm851080a91.16.2026.09.14.12.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 12:29:03 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 15 Sep 2026 04:30:15 +0900
To: Gregory Price <gourry@gourry.net>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	alison.schofield@intel.com, jic23@kernel.org, dave.jiang@intel.com,
	icheng@nvidia.com, ming.li@zohomail.com, vishal.l.verma@intel.com,
	dave@stgolabs.net, benjamin.cheatham@amd.com
Subject: Re: [RESEND PATCH v13 8/8] Documentation/cxl: Document DPA partition
 layout and ordering rules
Message-ID: <aqhLR36uRTXlqAUz@cxlqual>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-10-anisa.su@samsung.com>
 <aqSaZaaWaWUfKrC7@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqSaZaaWaWUfKrC7@gourry-fedora-PF4VCD3F>

On Fri, Sep 11, 2026 at 08:20:40PM -0400, Gregory Price wrote:
> On Tue, Sep 08, 2026 at 03:15:12AM -0700, Anisa Su wrote:
> 
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> 
> one question here, but not overly necessary to document because it
> instantly becomes the moment the code changes (for reasons).
> 
> > +
> > +Linux follows the static precedent anyway for the partition it maps: the
> > +first DC partition must begin at the DPA immediately following static
> > +capacity -- after pmem, after ram on a device with no pmem, or at DPA 0 on
> > +a device with no static capacity at all.
> > +
> 
> What is the reason for this requirement? Just easier to code?
> 
I think so. Although I didn't find anything in writing from the older
versions on the mailing list.

The current code doesn't know how to skip over DPA that doesn't belong to any
partition, so like you mentioned below probably just left as-is until a device
that needs the support shows up.

> is fine to leave as-is, the first device that comes along that needs
> it changed "for reasons" can fix it, but it seems an entirely reasonable
> restriction.
>
Thanks,
Anisa
