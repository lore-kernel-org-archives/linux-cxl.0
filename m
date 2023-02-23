Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDE9C61DA4
	for <linux-cxl@archiver.kernel.org>; Thu, 23 Feb 2023 16:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjBWQK3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 23 Feb 2023 11:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbjBWQK2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 23 Feb 2023 11:10:28 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4A958B4B
        for <linux-cxl@vger.kernel.org>; Thu, 23 Feb 2023 08:10:25 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id l13-20020a0568301d6d00b0068f24f576c5so2366803oti.11
        for <linux-cxl@vger.kernel.org>; Thu, 23 Feb 2023 08:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b21J6lC9bQtYZnkZz4fDVBzipk2M3qcEKC5jnxPkTvI=;
        b=Svgzd7tQ1NYb/P1Tg529jLmZphYA+U2EwzOXSVi1RparHLDEAX3Vre4D7zhVh8j8gA
         Q5D4KBCn/fs+aCU2qoYU4QqF9bfEQ8ALyTb2XSYl6d/wqmHDJf+hwiIEDWX3N7LJU2nO
         bS8F8njNy2CC2INBW+wNGhkHZAN8LhdVdk4UYLCuVkbBXLiptCGxwJn60BKkS/W64Ceq
         LYJJ4n9F1QFe3judfwFkuPQYBenMtMYOROxMXe//Bd0ppKe52n3sCBm3+mq+A1tth4DE
         4k8QMbG1FCKtEm92AD/WGJ7S/CcXgCuy7EeTKKk28ztnmlKKJQhIEAqF+MZu6QrbM6y6
         mK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b21J6lC9bQtYZnkZz4fDVBzipk2M3qcEKC5jnxPkTvI=;
        b=j5acE6tWEdjZ3Ce4Qlq5prTJwG7FQzkYKEvEXzS60I8Ls7FlEb0/rJjT9nG2ufaxAZ
         0A2G34Tn/pZsYnl34qx2jI5hDq4H5yOoOuXSPxME/Ks3nDXyVoqsYUPI2bbe2ebUWyW0
         agTFKzDAlpN0UUZAP9Z/3hyQBJSubg02XlM3mTRgVkpe0SrGpla2gQvLGdMI+v1ku6ka
         uLirNOVORCSRk/wr/9aG3HFelDwSUwF+VX3vZf4rg3czmeeO21d+X8pYgGG2clZSnWwd
         r9zeN2lbmXcjL65Mn3W/M89f6mKN+7HrwRE4ct5RfNqwz/9UZn6o0bMxS7iQ0OKxFVNn
         7OqQ==
X-Gm-Message-State: AO0yUKVSOL1tAba7bIHnq7BmcaO+0Np92698Ev0unWxpQrp/sBmf00Xr
        Pfoxa8XCI9fWGUx4Mn6B5R0MbnPOJE4=
X-Google-Smtp-Source: AK7set/iWgoGkK1hCUepnz2oCUcQqmu7pqzgYAwBzORpqv7Qjzgb3CDM67Dqtvo5XbnpZH2U7eCvTw==
X-Received: by 2002:a05:6830:43a9:b0:68b:d4ac:1ca0 with SMTP id s41-20020a05683043a900b0068bd4ac1ca0mr3006360otv.29.1677168624750;
        Thu, 23 Feb 2023 08:10:24 -0800 (PST)
Received: from nabeel-linux.myguest.virtualbox.org (cpe-76-183-103-62.tx.res.rr.com. [76.183.103.62])
        by smtp.gmail.com with ESMTPSA id i3-20020a05683033e300b00684152e9ff2sm2950281otu.0.2023.02.23.08.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 08:10:24 -0800 (PST)
Date:   Thu, 23 Feb 2023 10:10:21 -0600
From:   Nabeel M Mohamed <nabeelmd.linux@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com
Subject: Re: [PATCH v2] cxl/pci: Set the device timestamp
Message-ID: <Y/eP7deXlXMxf55s@nabeel-linux.myguest.virtualbox.org>
References: <20230130151327.32415-1-Jonathan.Cameron@huawei.com>
 <Y/Y19p8hqgYGkkKK@nabeel-linux.myguest.virtualbox.org>
 <20230222162700.00006d0f@Huawei.com>
 <Y/bjnb0gmmpkjk8r@nabeel-linux.myguest.virtualbox.org>
 <20230223150524.00002501@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223150524.00002501@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Feb 23, 2023 at 03:05:24PM +0000, Jonathan Cameron wrote:
> On Wed, 22 Feb 2023 21:55:09 -0600
> Nabeel M Mohamed <nabeelmd.linux@gmail.com> wrote:
> 
> > On Wed, Feb 22, 2023 at 04:27:00PM +0000, Jonathan Cameron wrote:
> > > On Wed, 22 Feb 2023 09:34:14 -0600
> > > Nabeel M Mohamed <nabeelmd.linux@gmail.com> wrote:
> > >   
> > > > On Mon, Jan 30, 2023 at 03:13:27PM +0000, Jonathan Cameron wrote:  
> > > > > CXL r3.0 section 8.2.9.4.2 "Set Timestamp" recommends that the host sets
> > > > > the timestamp after every Conventional or CXL Reset to ensure accurate
> > > > > timestamps. This should include on initial boot up. The time base that
> > > > > is being set is used by a device for the poison list overflow timestamp
> > > > > and all event timestamps.  Note that the command is optional and if
> > > > > not supported and the device cannot return accurate timestamps it will
> > > > > fill the fields in with an appropriate marker (see the specification
> > > > > description of each timestamp).
> > > > > 
> > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > >    
> > > > 
> > > > Hi Jonathan,
> > > > 
> > > > Could you please educate me on the reason for not supporting a
> > > > "Get Timestamp" mailbox command at this time?
> > > > 
> > > > A use-case that I can think of for having "Get Timestamp" in the UAPI
> > > > is to enable userspace to better correlate the timestamp in the device
> > > > logs with the wall time by querying the current timestamp on the device.
> > > > This could be useful if there's some inaccuracy or skew in the device
> > > > timestamp.
> > > > 
> > > > Would that be a valid use-case or am I misunderstanding something here?
> > > > 
> > > > I can see why "Set Timestamp" is a kernel-internal command but fail to
> > > > see why "Get Timestamp" cannot be in the UAPI.  
> > >   
> > 
> > > Hi Nabeel,
> > > 
> > > I'd be fine with a patch adding the support, it just didn't solve my
> > > immediate problem so I didn't want to make this patch more complex.
> > > 
> > > Jonathan  
> > 
> > Great, thanks for clarifying Jonathan!
> > 
> > I'll be happy to post a patch which adds support for "Get Timestamp".
> > 
> > Btw, this will be my first patch to the CXL driver.
> > So, I'm wondering if there's any checklist listing the prerequisites
> > for submitting a patch to the CXL driver - for instance, requirements
> > on adding new tests for coverage, any existing CXL regression suites
> > that the patch must pass, etc.
> > 
> > Any pointers on the above would be greatly appreciated!
> 
> As we are talking about a userspace exposed feature, support on the ndctl
> /cxl tools should probably follow soon after the kernel side of things.
> 
> Jonathan

Noted, thanks!
