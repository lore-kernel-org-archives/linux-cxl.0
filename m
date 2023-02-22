Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41409C64EC4
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Feb 2023 15:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjBVPeu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 22 Feb 2023 10:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjBVPeq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 22 Feb 2023 10:34:46 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6739C37B66
        for <linux-cxl@vger.kernel.org>; Wed, 22 Feb 2023 07:34:19 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id e12-20020a4ae0cc000000b00525034ca5e9so421769oot.0
        for <linux-cxl@vger.kernel.org>; Wed, 22 Feb 2023 07:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dBOlChnRgxluNIm4t7g0oDFa2nfW+NyRHC9GdtFiPMo=;
        b=GHNFwZLIbUhTIa3SlydhR8JrXXLnB97fkYja/croR+aXUuBchJCDuFIEUhR1srdA45
         giwyKzTFCIBOICdPVTfP2bN/M4a99LmUmngLgc5ZrMqGJdo4LwY1z503AozzkLmy2fEJ
         RuS+stnA7EnMHtpu+0uTH5MSooFMvbOhkgRd4LyhGk1A8UUZIPzyG0RkKl3cWf8ygxg9
         tdNrvLFQv9d/pXXM6oBR8l0YHqq4OTk/FCicbVm/Vuh1M7ZMG17E8N4yz6wiLCXY1+LX
         857BTo2t/C6wUSVwkOh1ujqxsBHVdLF0wl01iXJFFlLl6W+fGbJDp7GP8gGRGYlfrtao
         GaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBOlChnRgxluNIm4t7g0oDFa2nfW+NyRHC9GdtFiPMo=;
        b=SIZ6/VJvUuIMfWGyVsCXpYIYUaGzBJ9T9+7TwPgkBSq1BZuR0YwKSU4cYtyxYBCo72
         MrS97dn1uvJh56vpqbhooJ4iGsAgVSW87gcrwwSXfMIhj1VPE9U6SWIAI9AO7ImLT7cq
         zX58s6kIAOfqu9l2yLFlzZL/VehZhZg69W/DV+XLkE040BuxEJ2w47P/mXShXILrlOff
         t99U5l4CEt386ZoEleateNbJF62Z2zk67U7HJqYbRYzAoqwgdoI82TXBAerHwBcvaDgs
         l4MS3IYRCD8MUMfCxAPTIbSmHWe7I4Yrd77+xp5oB0tp0quZLaT0o8V7Ieds/F6tstn1
         k75g==
X-Gm-Message-State: AO0yUKUYjFU3N/JbOBHDU8Q8I12Rm4sfXRGr1xrCC+ialkqQhv12he82
        irHFnt+SG51GxrrPSye+INw=
X-Google-Smtp-Source: AK7set+f118klplUrsYC4GYzkQaQKJYV9e3pamROKLM1gfIa5cgIcTkfB34488hZ0lNK4pROkyLZPw==
X-Received: by 2002:a4a:d485:0:b0:4f2:8f8:d2ff with SMTP id o5-20020a4ad485000000b004f208f8d2ffmr3537914oos.6.1677080057868;
        Wed, 22 Feb 2023 07:34:17 -0800 (PST)
Received: from nabeel-linux.myguest.virtualbox.org (cpe-76-183-103-62.tx.res.rr.com. [76.183.103.62])
        by smtp.gmail.com with ESMTPSA id b8-20020a4ae808000000b005228aa095d3sm2227772oob.39.2023.02.22.07.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 07:34:17 -0800 (PST)
Date:   Wed, 22 Feb 2023 09:34:14 -0600
From:   Nabeel M Mohamed <nabeelmd.linux@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com
Subject: Re: [PATCH v2] cxl/pci: Set the device timestamp
Message-ID: <Y/Y19p8hqgYGkkKK@nabeel-linux.myguest.virtualbox.org>
References: <20230130151327.32415-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130151327.32415-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jan 30, 2023 at 03:13:27PM +0000, Jonathan Cameron wrote:
> CXL r3.0 section 8.2.9.4.2 "Set Timestamp" recommends that the host sets
> the timestamp after every Conventional or CXL Reset to ensure accurate
> timestamps. This should include on initial boot up. The time base that
> is being set is used by a device for the poison list overflow timestamp
> and all event timestamps.  Note that the command is optional and if
> not supported and the device cannot return accurate timestamps it will
> fill the fields in with an appropriate marker (see the specification
> description of each timestamp).
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>

Hi Jonathan,

Could you please educate me on the reason for not supporting a
"Get Timestamp" mailbox command at this time?

A use-case that I can think of for having "Get Timestamp" in the UAPI
is to enable userspace to better correlate the timestamp in the device
logs with the wall time by querying the current timestamp on the device.
This could be useful if there's some inaccuracy or skew in the device
timestamp.

Would that be a valid use-case or am I misunderstanding something here?

I can see why "Set Timestamp" is a kernel-internal command but fail to
see why "Get Timestamp" cannot be in the UAPI.

Please clarify.

Thanks,
Nabeel
