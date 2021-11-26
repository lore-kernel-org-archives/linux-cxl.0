Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C73AC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 26 Nov 2021 11:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbhKZLE1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 Nov 2021 06:04:27 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4170 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhKZLCY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 Nov 2021 06:02:24 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J0s8d2Kzrz67bWv;
        Fri, 26 Nov 2021 18:55:13 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 26 Nov 2021 11:59:09 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 26 Nov
 2021 10:59:09 +0000
Date:   Fri, 26 Nov 2021 10:59:07 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     Saransh Gupta1 <saransh@ibm.com>, <linux-cxl@vger.kernel.org>,
        <qemu-devel@nongnu.org>
Subject: Re: Follow-up on the CXL discussion at OFTC
Message-ID: <20211126105907.0000469a@Huawei.com>
In-Reply-To: <20211119185343.000020c0@Huawei.com>
References: <OF255704A1.78FEF164-ON0025878E.00821084-0025878F.00015560@ibm.com>
        <20211117165719.pqig62t5z2grgjvv@intel.com>
        <20211117173201.00002513@Huawei.com>
        <OF164E5BA6.E927FE73-ON00258791.0078E206-88258791.007ABBAD@ibm.com>
        <20211119015207.62fhk5mjmvaj5nz4@intel.com>
        <20211119185343.000020c0@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml746-chm.china.huawei.com (10.201.108.196) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 19 Nov 2021 18:53:43 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Thu, 18 Nov 2021 17:52:07 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > On 21-11-18 15:20:34, Saransh Gupta1 wrote:  
> > > Hi Ben and Jonathan,
> > > 
> > > Thanks for your replies. I'm looking forward to the patches.
> > > 
> > > For QEMU, I see hotplug support as an item on the list and would like to 
> > > start working on it. It would be great if you can provide some pointers 
> > > about how I should go about it.    
> > 
> > It's been a while, so I can't recall what's actually missing. I think it should
> > mostly behave like a normal PCIe endpoint.
> >   
> > > Also, which version of kernel and QEMU (maybe Jonathan's upcoming version) 
> > > would be a good starting point for it?    
> > 
> > If he rebased and claims it works I have no reason to doubt it :-). I have a
> > small fix on my v4 branch if you want to use the latest port patches.  
> 
> Thanks. I'd missed that one. Now pushed down into the original patch.
> 
> It occurred to me that technically I only know my rebase works on Arm64...
> Fingers crossed for x86.
> 
> Anyhow, I'll run more tests on it next week (possibly even including x86),

x86 tests throw up an issue with a 2 byte write to the box registers.
For now I've papered over that by explicitly adding support - obvious how to
do it if you look at mailbox_reg_read.  I want to understand what the source
of that access is though before deciding if this fix is correct and that might
take a little bit of tracking down.

Jonathan

> 
> Available at: 
> https://github.com/hisilicon/qemu/tree/cxl-hacks
> 
> For arm64 the description at
> https://people.kernel.org/jic23/ will almost work with this. 
> There is a bug however that I need to track down which currently means you
> need to set the pxb uid to the same as the bus number.   Shouldn't take
> long to fix but it's Friday evening...
> (add uid=0x80 to the options for pxb-cxl)
> 
> I dropped the CMA patch from Avery from this tree as need to improve
> the way it's getting hold of some parts of libSPDM and move to the current
> version of that library (rather than the old openSPDM)
> 
> Ben, if you don't mind me trying to push this forwards, I'll do a bit
> of cleanup and reordering then make use of the QEMU folks we have / know and
> try and start getting your hard work upstream.
> 
> Whilst I've not poked the various interfaces yet, this is working with
> a kernel tree that is current cxl/next + Ira's DOE series and Ben's region series
> + (for fun) my SPDM series.  That tree's a franken monster so I'm not planning
> to share it unless anyone has particular need of it.  Hopefully the various
> parts will move forwards this cycle anyway so I can stop having to spend
> as much time on rebases!
> 
> Jonathan 
> 
> >   
> > > 
> > > Thanks,
> > > Saransh
> > > 
> > > 
> > > 
> > > From:   "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>
> > > To:     "Ben Widawsky" <ben.widawsky@intel.com>
> > > Cc:     "Saransh Gupta1" <saransh@ibm.com>, <linux-cxl@vger.kernel.org>, 
> > > <qemu-devel@nongnu.org>
> > > Date:   11/17/2021 09:32 AM
> > > Subject:        [EXTERNAL] Re: Follow-up on the CXL discussion at OFTC
> > > 
> > > 
> > > 
> > > On Wed, 17 Nov 2021 08:57:19 -0800
> > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >     
> > > > Hi Saransh. Please add the list for these kind of questions. I've     
> > > converted your    
> > > > HTML mail, but going forward, the list will eat it, so please use text     
> > > only.    
> > > > 
> > > > On 21-11-16 00:14:33, Saransh Gupta1 wrote:    
> > > > >    Hi Ben,
> > > > > 
> > > > >    This is Saransh from IBM. Sorry to have (unintentionally) dropped     
> > > out    
> > > > >    of the conversion on OFTC, I'm new to IRC.
> > > > >    Just wanted to follow-up on the discussion there. We discussed     
> > > about    
> > > > >    helping with linux patches reviews. On that front, I have     
> > > identified    
> > > > >    some colleague(s) who can help me with this. Let me know if/how you
> > > > >    want to proceed with that.     
> > > > 
> > > > Currently the ball is in my court to re-roll the RFC v2 patches [1]     
> > > based on    
> > > > feedback from Dan. I've implemented all/most of it, but I'm still     
> > > debugging some    
> > > > issues with the result.
> > > >     
> > > > > 
> > > > >    Maybe not urgently, but my team would also like to get an     
> > > understanding    
> > > > >    of the missing pieces in QEMU. Initially our focus is on type3     
> > > memory    
> > > > >    access and hotplug support. Most of the work that my team does is
> > > > >    open-source, so contributing to the QEMU effort is another possible
> > > > >    line of collaboration.     
> > > > 
> > > > If you haven't seen it already, check out my LPC talk [2]. The QEMU     
> > > patches    
> > > > could use a lot of love. Mostly, I have little/no motivation until     
> > > upstream    
> > > > shows an interest because I don't have time currently to make sure I     
> > > don't break    
> > > > vs. upstream. If you want more details here, I can provide them, and I     
> > > will Cc    
> > > > the qemu-devel mailing list; the end of the LPC talk [2] does have a     
> > > list.
> > > Hi Ben, Saransh
> > > 
> > > I have a forward port of the series + DOE etc to near current QEMU that is 
> > > lightly tested,
> > > and can look to push that out publicly later this week.
> > > 
> > > I'd also like to push QEMU support forwards and to start getting this 
> > > upstream in QEMU
> > > + fill in some of the missing parts.
> > > 
> > > Was aiming to make progress on this a few weeks ago, but as ever other 
> > > stuff
> > > got in the way.
> > > 
> > > +CC qemu-devel in case anyone else also looking at this.
> > > 
> > > Jonathan
> > > 
> > > 
> > >     
> > > >     
> > > > > 
> > > > >    Thanks for your help and guidance!
> > > > > 
> > > > >    Best,
> > > > >    Saransh Gupta
> > > > >    Research Staff Member, IBM Research     
> > > > 
> > > > [1]:     
> > > https://lore.kernel.org/linux-cxl/20211022183709.1199701-1-ben.widawsky@intel.com/T/#t 
> > >     
> > > > [2]:     
> > > https://www.youtube.com/watch?v=g89SLjt5Bd4&list=PLVsQ_xZBEyN3wA8Ej4BUjudXFbXuxhnfc&index=49 
> > > 
> > > 
> > > 
> > > 
> > > 
> > >     
> 

