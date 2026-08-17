Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06E33F8883
	for <linux-cxl@vger.kernel.org>; Mon, 17 Aug 2026 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786967622; cv=none; b=fPE+2fBnxJwIAGNCfBXL8jpRa1retPjvzgbdB6gR10LKkCeFj9YiTiYDlgSX7RDn8C8vhV1YCDoEu9QcHSS+WNRjVwl8wsh9jhUNLi3+8yr7OmOcQyj+D8C/llpTRlgYXZkYpyFK/ffKGLP1gIVdBL4KESZ7rknm7QujntqfTOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786967622; c=relaxed/simple;
	bh=PAmw6WTW/ZyfAupkuIhTWB954fQWbyPsft7VxciVQNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3ziXHC3D7Zu6I61JeuNIPAyken04HmqFp2htWcrTbstOA9Qd3/yixizk7h3esIcJvhkJk83fuoxieLTnkRdNz4GRXfr5N03PwhiyH81IyNf9yPNIg4HNovf8k7B3wOQtJNg3Q22pC/FWkvoXZefbyoThoFuun3pyRDQ78Ulimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEBl7TsX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEBl7TsX"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84fa3b14ee1so2393907b3a.0
        for <linux-cxl@vger.kernel.org>; Mon, 17 Aug 2026 04:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786967620; x=1787572420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9v8a/sXDWYsOopBVMotsfawyjbAT4V/KurGnLYvjd0o=;
        b=YEBl7TsXXEKXbESbtIgPJ1tQZJLym9Cg9UD4QC+5xU5PVyP58RqSlXnYlZxx5whPTJ
         uR0jDSau/dEL71VLXbMuJjbfdt+DT+XDgr0OXJmuMvGpDdLZhjSzzKj6M48tVKswVBK+
         z2Qh97owjlkSZVfSaDPh9JarhjbCP4mB7OuzlSOhFv4EGZMrQhZCdlueHl5Zx8s2YDgX
         J9mwlVi6GegAqmg//905HwL/MfjJj1Rx1rWr4KROy2ZzM+7Z7ey73AkPcKmKoWmUtsaS
         F14bW/aS6Qnrf3+Em92e2v9NgoOBbaLDJYaxpNZ/+VaDnpphAp/qbEXet0rI0cHPAtCU
         GYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786967620; x=1787572420;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9v8a/sXDWYsOopBVMotsfawyjbAT4V/KurGnLYvjd0o=;
        b=olt9BU9NsSXLGA2CLVwoGyUlcdbCehqY6lL+hlMOFeVrUi1Od5eJqw2xXX1pn2xa2q
         L6Tg159qGkZWn3H2Ko49eInCexUPJZ6+rvHpMMVU2pqx91G2jF5Ltx8D/ItXbNICpyq4
         LepUvSr8yayG78or8yKC9nF93vCkzCOmlHJpVDiPDq0D+Ov4/jO86gX6vxxesdr6UqMj
         rlE0dTSlp5aO0Yux9VjK5fZ1/c69FZCRR4v5omXF1g8vvE9ss3POHi9koyzn0elEGdru
         lb9VLV1ASL6A5YhXah82TlubPYXmlShzNCEoZD+tB1lfEuDaWST5b+c2VOwYtYIFGuVp
         vTDw==
X-Forwarded-Encrypted: i=1; AHgh+Rptfvgye2GjSeAqNpkMv8ku+806+f55zRf5sZ0vX4f8LSvS8NY4ILnGw1NL9N8MIx0plqlwWQzDvnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzIW40BANWKZpSbqPxMiX8NpEQhCLhP7byk2jZ0OeSRG9xYjAU
	94LrKL0IRMLVOgjhKLAzCyMDikc2a3z5wBejPcsMyzH/M0nmaBQgK6uz
X-Gm-Gg: AR+sD13NoFOdBh7yl2qk2zj0XALqSAN4CiQ9fcxWXBK2w+06kvuA2OH3qMPLCbxmmaQ
	zYEknjK/rcUVne/4/s/vPKn9Tk1KmLXU937zIx/X1Yo9gLyjSWhgFCszwzsYSPAWFPRI3hJ/YIe
	tMuCmzqp6Opj3MN4M4QtYUsmSshKFxVuPz4vZX7KmHYMexMhK3S4GEaaDOzXO/3Ef1/UZQmNj5w
	nBZp3tBB0JVesUOMvKvpClu3NuqMhniirlPR+7blpW63EBp1Pd39ZjQw8I5x7T3CIkDIXHsItkf
	Rsr8Jk4iV15/GIHTLu4Ajb8cAjCGXqx9kFr4YJUdsW9fpFGR3/KlbazyD2kyAS03V0ttyNUjaOr
	O/tw3oamkKgFSN7+yH3NM9k2QQVKxO0lPEZnA/j7D29C7i6hFA6HHtR3p2MnEpv7io6HiRfkeD7
	EymAfQ8gq8nc86H79Gf8bRnu2pzLIzBZ1VZePLhoZLbJLWwsCQADhJEfsHPcYa5+o=
X-Received: by 2002:a05:6a00:18a9:b0:847:9015:e68c with SMTP id d2e1a72fcca58-851b8843838mr90857b3a.17.1786967619919;
        Mon, 17 Aug 2026 04:53:39 -0700 (PDT)
Received: from localhost ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b404f349sm419599b3a.24.2026.08.17.04.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 04:53:39 -0700 (PDT)
Date: Mon, 17 Aug 2026 17:23:37 +0530
From: shaikh kamaluddin <shaikhkamal2012@gmail.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>, tony.luck@intel.com, bp@alien8.de,
	linux-cxl@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH] cxl/mce: Only act on uncorrected memory errors
Message-ID: <aoL2QSTlDoAQhWhv@acer-nitro-anv15-41>
References: <20260810183013.47085-1-shaikhkamal2012@gmail.com>
 <8cef03f0-ab19-42b7-ad04-a1e98e2270ec@amd.com>
 <anyYev89TB1jHAXe@acer-nitro-anv15-41>
 <e0f20e5c-91af-4f9d-b1fb-b00eaef76f58@amd.com>
 <anz2yiHLrDFhkxuv@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anz2yiHLrDFhkxuv@aschofie-mobl2.lan>

On Wed, Aug 12, 2026 at 03:42:18PM -0700, Alison Schofield wrote:
> On Wed, Aug 12, 2026 at 11:19:40AM -0500, Cheatham, Benjamin wrote:
> > On 8/12/2026 10:59 AM, shaikh kamaluddin wrote:
> > > [You don't often get email from shaikhkamal2012@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > 
> > > On Mon, Aug 10, 2026 at 02:00:18PM -0500, Cheatham, Benjamin wrote:
> > >> On 8/10/2026 1:30 PM, Shaikh Kamaluddin wrote:
> > >>> [You don't often get email from shaikhkamal2012@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > >>>
> > >>> cxl_handle_mce() offlines the aliased page of an ELC region on any
> > >>> record with a usable address; it does not check MCI_STATUS_UC or
> > >>> filter non-memory errors. uc_decode_notifier(), the equivalent
> > >>> handler for plain memory on the same chain at the same priority,
> > >>> filters on mce->severity and leaves corrected errors untouched.
> > >>> cxl_handle_mce() has no such gate, so a corrected error - which
> > >>> the generic handler ignores - still causes the alias to be
> > >>> permanently retired via memory_failure().
> > >>>
> > >>> Corrected errors do reach the chain: machine_check_poll() logs
> > >>> them via the same mce_gen_pool_process() path that feeds
> > >>> x86_mce_decoder_chain, and cxl_extended_linear_cache_resize()
> > >>> extends p->res to cover the DRAM half of the ELC pair, so a
> > >>> routine DRAM CE carries an address inside the region resource.
> > >>>
> > >>> Filter the record as nfit_handle_mce() does. Commit fc08a4703a41
> > >>> ("acpi, nfit: Fix the memory error check in nfit_handle_mce()") and
> > >>> commit 5d96c9342c23 ("acpi/nfit, x86/mce: Handle only uncorrectable
> > >>> machine checks") established this filter for an equivalent handler
> > >>> on the same notifier chain; the consequence here is more severe, as
> > >>> the CXL handler calls memory_failure() rather than recording a bad
> > >>> block.
> > >>>
> > >>> mce_is_correctable() is used instead of copying
> > >>> uc_decode_notifier()'s AO/DEFERRED test because the alias must
> > >>> still be offlined on MCE_AR_SEVERITY, where kill_me_maybe() owns
> > >>> the reported page but nothing owns the alias.
> > >>>
> > >>> Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
> > >>>
> > >>> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> > >>> ---
> > >>
> > >> This looks good to me, so:
> > >> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> > >>
> > > Thanks for review!
> > >> If you have the time, could you also share a script that does the below testing on the list? It may
> > >> be possible to integrate into the CXL testing suite (see https://github.com/pmem/ndctl.git), though
> > >> the QEMU usage may throw a wrench in that. Even if it's not possible, having the tests out there
> > >> for people to run would help with any future breakage.
> > > Happy to share it. One question on where it'd fit best: ndctl
> > > (github.com/pmem/ndctl.git) as you mentioned, or drivers/cxl's own
> > > tools/testing/cxl/ in-tree? I'm open to either, or proposing it in
> > > both if that's useful - happy to follow your lead on which is the
> > > better home for it.
> > > 
> > 
> > If looks like there's already some mock functions for extended linear cache in tools/testing/cxl, so
> > I'd recommending trying to put it there to begin with. It may require updates to ndctl after the fact
> > to run the test(s) as well. If that looks too involved then sending the script out to the list standalone
> > should be fine. I don't know if anyone will pick it up, but it'll be searchable on lore if anyone wants
> > to test this.
> 
> 
> This sounded interesting! I gave it a try with cxl_test and mce-inject,
> and it looks like this can be tested without the QEMU CXL topology or the
> forced cache_size hack.
> 
> I built with CONFIG_X86_MCE_INJECT=m and loaded cxl_test with its
> existing ELC support:
> 
> # modprobe cxl_test extended_linear_cache=1
> # cxl list -R
> [
>   {
>     "region":"region0",
>     "resource":70300293136384,
>     "size":1073741824,
>     "extended_linear_cache_size":536870912,
>     "type":"ram",
>     "interleave_ways":2,
>     "interleave_granularity":4096,
>     "decode_state":"commit",
>     "locked":false
>   }
> ]
> 
> Using 0x3ff010010000 as the injected SPA, I first injected the
> corrected error from your example. On the patched kernel there was no
> CXL offlining message, as expected.
> 
> I then changed only the status to the uncorrectable case:
> 
> # cd /sys/kernel/debug/mce-inject
> # echo sw > flags
> # echo 0xbc00000000000080 > status
> # echo 0x80 > misc
> # echo 0x3ff010010000 > addr
> # echo 9 > bank
> 
> and got:
> 
> cxl_region region0: Offlining aliased SPA address0: 0x3ff030010000
> Memory failure: 0x3ff030010: memory outside kernel control
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: bc00000000000080
> mce: [Hardware Error]: TSC 23c5a5a9188 ADDR 3ff010010000 MISC 80
> mce: [Hardware Error]: PROCESSOR 0:50657 TIME 1786573477 SOCKET 0 APIC 0 microcode 5003302
> 
> So the cxl_test ELC plus mce-inject looks sufficient to exercise the
> path: the CE is ignored with the patch, while the UC reaches the alias
> offlining path and computes the expected alias.
> 
> The "memory outside kernel control" is because I did not put the
> aliased memory into system RAM for this quick test.
> 
> This would be a test case addition for the the cxl-elc.sh unit test.
> It seems like a tiny, close-the-barn-door-after-the-horse-got-out,
> kind of test case, but maybe not?  Maybe it opens the door to more
> things can do we mce-inject elsewhere?
> 
> I'll leave that to Shaikh if they want to add the new test case.
> 
> -- Alison


Hi Alison,

Thanks for trying this. This is very helpful.

I had initially started with the same cxl_test + mce-inject approach before moving to the vng/QEMU CXL Type-3 setup.

On the current cxl/next tree, I was first blocked while building tools/testing/cxl with LLVM/ld.lld. modpost was failing on wrapped CXL symbols, for example:

.export_symbol section references '__wrap_devm_cxl_add_rch_dport',
but it does not seem to be an export symbol

.export_symbol section references '__wrap_devm_cxl_add_dport_by_dev',
but it does not seem to be an export symbol

.export_symbol section references '__wrap_cxl_await_media_ready',
but it does not seem to be an export symbol

There were similar failures for some of the decoder/CDAT wrappers.

This appears to be the same issue addressed by the patch currently under review:

[PATCH] tools/testing/cxl: Don't wrap cxl_core's own exported symbols

https://lore.kernel.org/linux-cxl/20260721084009.38100-1-icheng@nvidia.com/

The patch avoids globally wrapping the CXL core symbols that are also defined/exported by cxl_core, and instead applies those wrappers only to the modules that need them.

With that patch applied, tools/testing/cxl builds successfully for me. However, I still hit a runtime crash when loading the ELC setup:

# modprobe cxl_test extended_linear_cache=1

BUG: unable to handle page fault for address: 0000000000003358
#PF: supervisor read access in kernel mode
RIP: __alloc_frozen_pages_noprof+0x12e/0x320
CR2: 0000000000003358
Workqueue: async async_run_entry_fn

So the build issue and this runtime crash appear to be separate problems. The runtime failure is what led me to use the vng/QEMU CXL Type-3 setup for validating the MCE change, where I was able to exercise both the CE and UC cases.

Since you were able to run:

modprobe cxl_test extended_linear_cache=1
        +
mce-inject

successfully, could you please share the kernel configuration and any patches you have on top of cxl/next? That would help me compare the working setup with mine and identify what I am still missing on the cxl_test side.

Your result also confirms that, once I get this setup stable, extending the existing cxl-elc.sh test looks like the right direction for regression coverage. My plan would be to derive the SPA and expected alias dynamically from the ELC region, inject a CE and verify that the alias-offlining path is not reached, then inject a UC and verify that the expected aliased SPA is still offlined.

This is a small regression test for the current issue, but exercising mce-inject through the CXL test infrastructure may also provide useful coverage for other CXL RAS/MCE paths in the future.

For the current patch validation, I still think the vng/QEMU Type-3 setup is useful as an end-to-end test since it can exercise the actual CXL region and system-RAM memory_failure() path, while cxl_test + mce-inject looks better suited for the lightweight automated regression test.

Thanks,
Shaikh


> 
> > 
> > Thanks,
> > Ben
